import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/nutrition/ingredient.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/nutrition/recipe_catalog.dart';

import 'food_reference.dart';

enum CustomFoodKind { product, dish }

/// Ингредиент своего блюда: продукт и его вес.
class FoodPart {
  const FoodPart({required this.name, required this.grams, required this.per100});

  final String name;
  final double grams;
  final Macros per100;

  Macros get macros => per100 * (grams / 100);

  Map<String, Object> toJson() => {
        'name': name,
        'grams': grams,
        'per100': [per100.kcal, per100.protein, per100.fat, per100.carbs],
      };

  factory FoodPart.fromJson(Map<String, dynamic> j) => FoodPart(
        name: j['name'] as String,
        grams: (j['grams'] as num).toDouble(),
        per100: Macros.fromList(j['per100'] as List),
      );
}

/// Свой продукт (полуфабрикат с этикетки) или своё блюдо из ингредиентов.
class CustomFood {
  const CustomFood({
    this.id,
    required this.kind,
    required this.name,
    required this.per100,
    this.portionG,
    this.totalWeightG,
    this.parts = const [],
    this.mealTypes = const [],
    this.photo,
  });

  final int? id;
  final CustomFoodKind kind;
  final String name;

  /// КБЖУ на 100 г.
  final Macros per100;

  /// Вес порции или упаковки, г.
  final double? portionG;

  /// Вес готового блюда, г.
  final double? totalWeightG;
  final List<FoodPart> parts;

  /// Пусто — подходит для любого приёма пищи.
  final List<MealType> mealTypes;
  final Uint8List? photo;

  static String keyFor(int id) => 'custom-$id';

  /// КБЖУ на 100 г блюда из ингредиентов с учётом уварки до [cookedG].
  static Macros per100Of(List<FoodPart> parts, double? cookedG) {
    final total = parts.fold(Macros.zero, (Macros s, p) => s + p.macros);
    final raw = parts.fold(0.0, (s, p) => s + p.grams);
    final weight = cookedG ?? raw;
    return weight <= 0 ? Macros.zero : total * (100 / weight);
  }

  /// Представление в каталоге: работает в дневнике, плане, запасах и покупках.
  Recipe toRecipe() {
    final portion = portionG ?? (kind == CustomFoodKind.product ? 100 : totalWeightG ?? 100);
    final isDish = kind == CustomFoodKind.dish;
    String grams(double g) => Ingredient.formatAmount(g, QtyUnit.g);
    return Recipe(
      key: keyFor(id!),
      name: name,
      book: isDish ? 'Мои блюда' : 'Мои продукты',
      category: isDish ? 'Мои блюда' : 'Мои продукты',
      mealTypes: mealTypes.isEmpty ? MealType.values : mealTypes,
      ingredients: isDish
          ? [for (final p in parts) '${p.name} - ${grams(p.grams)} г']
          : ['$name - ${grams(portion)} г'],
      steps: const [],
      per100: per100,
      portionG: portion,
      totalWeightG: isDish ? (totalWeightG ?? parts.fold<double>(0, (s, p) => s + p.grams)) : portion,
      photo: photo,
      customId: id,
    );
  }

  /// Для поиска ингредиентов в своих блюдах.
  FoodRef toFoodRef() => FoodRef(name, per100.kcal, per100.protein, per100.fat, per100.carbs, custom: true);
}

abstract class CustomFoodRepository {
  Stream<List<CustomFood>> watchAll();

  /// Добавляет (id == null) или обновляет; возвращает id.
  Future<int> save(CustomFood food);

  Future<void> delete(int id);
}

class InMemoryCustomFoodRepository implements CustomFoodRepository {
  final _items = <CustomFood>[];
  final _changes = StreamController<void>.broadcast();
  var _nextId = 1;

  @override
  Stream<List<CustomFood>> watchAll() {
    StreamSubscription<void>? sub;
    late final StreamController<List<CustomFood>> out;
    out = StreamController(
      onListen: () {
        out.add(List.of(_items));
        sub = _changes.stream.listen((_) => out.add(List.of(_items)));
      },
      onCancel: () => sub?.cancel(),
    );
    return out.stream;
  }

  @override
  Future<int> save(CustomFood f) async {
    final id = f.id ?? _nextId++;
    final item = CustomFood(
      id: id,
      kind: f.kind,
      name: f.name,
      per100: f.per100,
      portionG: f.portionG,
      totalWeightG: f.totalWeightG,
      parts: f.parts,
      mealTypes: f.mealTypes,
      photo: f.photo,
    );
    final i = _items.indexWhere((e) => e.id == id);
    if (i >= 0) {
      _items[i] = item;
    } else {
      _items.add(item);
    }
    _changes.add(null);
    return id;
  }

  @override
  Future<void> delete(int id) async {
    _items.removeWhere((e) => e.id == id);
    _changes.add(null);
  }
}

class DriftCustomFoodRepository implements CustomFoodRepository {
  DriftCustomFoodRepository(this.db);

  final AppDatabase db;

  @override
  Stream<List<CustomFood>> watchAll() {
    final q = db.select(db.customFoods)..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return q.watch().map((rows) => [
          for (final r in rows)
            CustomFood(
              id: r.id,
              kind: r.kind == 'dish' ? CustomFoodKind.dish : CustomFoodKind.product,
              name: r.name,
              per100: Macros(kcal: r.kcal, protein: r.protein, fat: r.fat, carbs: r.carbs),
              portionG: r.portionG,
              totalWeightG: r.totalWeightG,
              parts: r.partsJson == null
                  ? const []
                  : [
                      for (final j in jsonDecode(r.partsJson!) as List)
                        FoodPart.fromJson(j as Map<String, dynamic>),
                    ],
              mealTypes: [
                for (final c in r.mealTypes.split(',')) ?MealType.tryParse(c),
              ],
              photo: r.photo,
            ),
        ]);
  }

  @override
  Future<int> save(CustomFood f) async {
    final companion = CustomFoodsCompanion(
      kind: Value(f.kind.name),
      name: Value(f.name),
      kcal: Value(f.per100.kcal),
      protein: Value(f.per100.protein),
      fat: Value(f.per100.fat),
      carbs: Value(f.per100.carbs),
      portionG: Value(f.portionG),
      totalWeightG: Value(f.totalWeightG),
      partsJson: Value(f.parts.isEmpty ? null : jsonEncode([for (final p in f.parts) p.toJson()])),
      mealTypes: Value(f.mealTypes.map((m) => m.name).join(',')),
      photo: Value(f.photo),
    );
    if (f.id == null) return db.into(db.customFoods).insert(companion);
    await (db.update(db.customFoods)..where((t) => t.id.equals(f.id!))).write(companion);
    return f.id!;
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.customFoods)..where((t) => t.id.equals(id))).go();
  }
}

/// Свои продукты и блюда; держит их в каталоге рецептов.
class CustomFoodsController extends ChangeNotifier {
  CustomFoodsController({required this.repository, required this.catalog});

  final CustomFoodRepository repository;
  final RecipeCatalog catalog;
  StreamSubscription<List<CustomFood>>? _sub;
  List<CustomFood> _foods = const [];

  List<CustomFood> get foods => _foods;

  CustomFood? byId(int id) => _foods.where((f) => f.id == id).firstOrNull;

  /// Справочник для ингредиентов: свои продукты и блюда, затем базовые.
  List<FoodRef> get allFoodRefs => [for (final f in _foods) f.toFoodRef(), ...foodReference];

  Future<void> init() {
    final first = Completer<void>();
    _sub = repository.watchAll().listen((rows) {
      _foods = rows;
      catalog.setCustom([for (final f in rows) f.toRecipe()]);
      notifyListeners();
      if (!first.isCompleted) first.complete();
    });
    return first.future;
  }

  Future<int> save(CustomFood f) => repository.save(f);

  Future<void> delete(CustomFood f) => repository.delete(f.id!);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
