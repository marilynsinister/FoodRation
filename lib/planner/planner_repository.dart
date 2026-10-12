import 'dart:async';

import 'package:food_ration/nutrition/ingredient.dart';
import 'package:food_ration/nutrition/recipe.dart';

class PlanEntry {
  const PlanEntry({
    this.id,
    required this.dayKey,
    required this.meal,
    required this.recipeKey,
    this.servings = 1,
    this.done = false,
  });

  final int? id;
  final String dayKey;
  final MealType meal;
  final String recipeKey;

  /// Сколько порций готовится: на столько рассчитываются продукты.
  final double servings;

  /// Приготовлено — продукты уже списаны из запасов.
  final bool done;

  PlanEntry copyWith({double? servings, bool? done, int? id}) => PlanEntry(
        id: id ?? this.id,
        dayKey: dayKey,
        meal: meal,
        recipeKey: recipeKey,
        servings: servings ?? this.servings,
        done: done ?? this.done,
      );
}

enum PantryUnit {
  g('г', QtyKind.mass),
  ml('мл', QtyKind.mass),
  pcs('шт', QtyKind.count);

  const PantryUnit(this.label, this.kind);

  final String label;
  final QtyKind kind;

  static PantryUnit parse(String code) =>
      values.firstWhere((u) => u.name == code, orElse: () => PantryUnit.g);
}

/// Купленный продукт с текущим остатком.
class PantryItem {
  PantryItem({this.id, required this.name, required this.amount, required this.unit});

  final int? id;
  final String name;
  final double amount;
  final PantryUnit unit;

  late final List<String> tokens = Ingredient.nameTokens(Ingredient.cleanName(name));

  PantryItem copyWith({String? name, double? amount, PantryUnit? unit}) => PantryItem(
        id: id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        unit: unit ?? this.unit,
      );

  /// «500 г», «1,5 л», «10 шт».
  static String formatQty(double amount, PantryUnit unit) {
    String n(double v, int digits) {
      final s = v.toStringAsFixed(digits);
      return s.contains('.') ? s.replaceFirst(RegExp(r'\.?0+$'), '').replaceAll('.', ',') : s;
    }

    switch (unit) {
      case PantryUnit.g:
        return amount >= 1000 ? '${n(amount / 1000, 2)} кг' : '${amount.round()} г';
      case PantryUnit.ml:
        return amount >= 1000 ? '${n(amount / 1000, 2)} л' : '${amount.round()} мл';
      case PantryUnit.pcs:
        return '${n(amount, 1)} шт';
    }
  }
}

abstract class PlannerRepository {
  Stream<List<PlanEntry>> watchPlan();

  Future<void> addPlanEntry(PlanEntry entry);

  Future<void> updatePlanEntry(PlanEntry entry);

  Future<void> deletePlanEntry(int id);

  Stream<List<PantryItem>> watchPantry();

  /// Добавляет продукт (id == null) или обновляет существующий.
  Future<void> savePantryItem(PantryItem item);

  Future<void> deletePantryItem(int id);
}

/// Хранение в памяти: веб-сборка и тесты.
class InMemoryPlannerRepository implements PlannerRepository {
  final _plan = <PlanEntry>[];
  final _pantry = <PantryItem>[];
  final _changes = StreamController<void>.broadcast();
  var _nextId = 1;

  /// Подписка на изменения оформляется сразу при listen, чтобы не терять
  /// изменения, сделанные до первой асинхронной паузы.
  Stream<T> _watch<T>(T Function() snapshot) {
    StreamSubscription<void>? sub;
    late final StreamController<T> out;
    out = StreamController<T>(
      onListen: () {
        out.add(snapshot());
        sub = _changes.stream.listen((_) => out.add(snapshot()));
      },
      onCancel: () => sub?.cancel(),
    );
    return out.stream;
  }

  @override
  Stream<List<PlanEntry>> watchPlan() => _watch(() => List.of(_plan));

  @override
  Future<void> addPlanEntry(PlanEntry e) async {
    _plan.add(e.copyWith(id: _nextId++));
    _changes.add(null);
  }

  @override
  Future<void> updatePlanEntry(PlanEntry e) async {
    final i = _plan.indexWhere((p) => p.id == e.id);
    if (i >= 0) _plan[i] = e;
    _changes.add(null);
  }

  @override
  Future<void> deletePlanEntry(int id) async {
    _plan.removeWhere((p) => p.id == id);
    _changes.add(null);
  }

  @override
  Stream<List<PantryItem>> watchPantry() => _watch(() => List.of(_pantry));

  @override
  Future<void> savePantryItem(PantryItem item) async {
    if (item.id == null) {
      _pantry.add(PantryItem(id: _nextId++, name: item.name, amount: item.amount, unit: item.unit));
    } else {
      final i = _pantry.indexWhere((p) => p.id == item.id);
      if (i >= 0) _pantry[i] = item;
    }
    _changes.add(null);
  }

  @override
  Future<void> deletePantryItem(int id) async {
    _pantry.removeWhere((p) => p.id == id);
    _changes.add(null);
  }
}
