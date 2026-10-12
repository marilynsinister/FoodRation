import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:food_ration/nutrition/ingredient.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/nutrition_repository.dart' show dayKeyOf;
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/nutrition/recipe_catalog.dart';

import 'planner_repository.dart';

/// Потребность блюда в одном продукте и сколько её покрывают запасы.
class NeedLine {
  NeedLine({required this.ingredient, required this.need, required this.kind, this.item});

  final Ingredient ingredient;

  /// Продукт из запасов, из которого берётся ингредиент.
  final PantryItem? item;

  /// Сколько нужно, в единицах [item] (или натуральных для ингредиента без пары).
  final double need;
  final QtyKind kind;
  double covered = 0;

  double get shortage => need - covered;

  bool get isShort => shortage > _eps(kind);
}

double _eps(QtyKind kind) => kind == QtyKind.count ? 0.05 : 0.5;

class EntryProjection {
  EntryProjection(this.entry, this.recipe, this.lines);

  final PlanEntry entry;
  final Recipe recipe;
  final List<NeedLine> lines;

  /// Ингредиенты с количеством, которых не хватает в запасах.
  late final List<NeedLine> missing = [for (final l in lines) if (l.isShort) l];

  /// Ингредиенты, частично или полностью взятые из запасов.
  late final List<NeedLine> fromPantry = [for (final l in lines) if (l.covered > 0) l];
}

/// Позиция списка покупок.
class ShoppingItem {
  ShoppingItem({required this.name, required this.unit, required this.tokens});

  final String name;
  final PantryUnit unit;
  final List<String> tokens;
  double amount = 0;
  final recipes = <String>{};
}

/// Расход запасов по меню и что докупить.
class PlanProjection {
  PlanProjection({
    required this.entries,
    required this.planned,
    required this.remaining,
    required this.shopping,
    required this.unmeasured,
  });

  final Map<int, EntryProjection> entries;

  /// Сколько каждого продукта (id) уйдёт на неприготовленные блюда.
  final Map<int, double> planned;

  /// Остаток после всех блюд плана.
  final Map<int, double> remaining;
  final List<ShoppingItem> shopping;

  /// Ингредиенты без количества («соль по вкусу»), по названиям.
  final List<String> unmeasured;
}

/// Рецепт, подобранный под остатки продуктов.
class PantrySuggestion {
  PantrySuggestion(this.recipe, this.lines);

  final Recipe recipe;
  final List<NeedLine> lines;

  /// Сколько каждого продукта из запасов уйдёт на блюдо.
  late final Map<PantryItem, double> used = () {
    final m = <PantryItem, double>{};
    for (final l in lines) {
      if (l.covered > 0) m[l.item!] = (m[l.item!] ?? 0) + l.covered;
    }
    return m;
  }();

  late final int missing = lines.where((l) => l.isShort).length;

  /// Доля ингредиентов с количеством, полностью покрытых запасами.
  double get coverage => lines.isEmpty ? 0 : lines.where((l) => !l.isShort).length / lines.length;
}

/// Недельное меню, запасы продуктов и список покупок.
class PlannerController extends ChangeNotifier {
  PlannerController({required this.repository, required this.catalog, DateTime Function()? clock})
      : _clock = clock ?? DateTime.now;

  final PlannerRepository repository;
  final RecipeCatalog catalog;
  final DateTime Function() _clock;

  List<PlanEntry> _plan = const [];
  List<PantryItem> _pantry = const [];
  final _subs = <StreamSubscription<Object?>>[];
  PlanProjection? _projection;

  List<PlanEntry> get plan => _plan;

  List<PantryItem> get pantry => _pantry;

  DateTime get today {
    final n = _clock();
    return DateTime(n.year, n.month, n.day);
  }

  Future<void> init() async {
    final firstPlan = Completer<void>();
    final firstPantry = Completer<void>();
    _subs.add(repository.watchPlan().listen((rows) {
      _plan = rows;
      _changed();
      if (!firstPlan.isCompleted) firstPlan.complete();
    }));
    _subs.add(repository.watchPantry().listen((rows) {
      _pantry = rows;
      _changed();
      if (!firstPantry.isCompleted) firstPantry.complete();
    }));
    catalog.addListener(_changed);
    await Future.wait([firstPlan.future, firstPantry.future]);
  }

  void _changed() {
    _projection = null;
    notifyListeners();
  }

  List<PlanEntry> entriesFor(String dayKey, MealType meal) =>
      [for (final e in _plan) if (e.dayKey == dayKey && e.meal == meal) e];

  /// КБЖУ дня из расчёта одна порция каждого блюда на человека.
  Macros dayMacros(String dayKey) {
    var sum = Macros.zero;
    for (final e in _plan) {
      if (e.dayKey != dayKey) continue;
      final r = catalog.byKey(e.recipeKey);
      if (r != null) sum += r.defaultPortionMacros;
    }
    return sum;
  }

  PlanProjection get projection => _projection ??= _project();

  PlanProjection _project() {
    final remaining = {for (final p in _pantry) p.id!: p.amount};
    final entries = <int, EntryProjection>{};
    final shopping = <ShoppingItem>[];
    final unmeasured = <String>{};
    final todayKey = dayKeyOf(today);
    final upcoming = [
      for (final e in _plan)
        if (!e.done && e.dayKey.compareTo(todayKey) >= 0) e,
    ]..sort((a, b) {
        final d = a.dayKey.compareTo(b.dayKey);
        if (d != 0) return d;
        final m = a.meal.index.compareTo(b.meal.index);
        return m != 0 ? m : (a.id ?? 0).compareTo(b.id ?? 0);
      });
    for (final e in upcoming) {
      final r = catalog.byKey(e.recipeKey);
      if (r == null) continue;
      final lines = allocate(r, e.servings, remaining);
      entries[e.id!] = EntryProjection(e, r, lines);
      for (final l in lines) {
        if (l.isShort) _addShopping(shopping, l, r.name);
      }
      for (final i in r.parsedIngredients) {
        if (!i.tracked && i.name.isNotEmpty) unmeasured.add(i.name);
      }
    }
    return PlanProjection(
      entries: entries,
      planned: {for (final p in _pantry) p.id!: p.amount - remaining[p.id!]!},
      remaining: remaining,
      shopping: shopping..sort((a, b) => a.name.compareTo(b.name)),
      unmeasured: unmeasured.toList()..sort(),
    );
  }

  void _addShopping(List<ShoppingItem> list, NeedLine l, String recipeName) {
    final name = l.item?.name ?? l.ingredient.name;
    final tokens = l.item?.tokens ?? l.ingredient.tokens;
    final unit = l.item?.unit ??
        switch (l.ingredient.unit) {
          QtyUnit.pcs => PantryUnit.pcs,
          QtyUnit.ml => PantryUnit.ml,
          _ => PantryUnit.g,
        };
    ShoppingItem? target;
    for (final s in list) {
      if (s.unit.kind == unit.kind &&
          s.tokens.length == tokens.length &&
          Ingredient.nameCovers(s.tokens, tokens)) {
        target = s;
        break;
      }
    }
    target ??= ShoppingItem(name: name, unit: unit, tokens: tokens);
    if (!list.contains(target)) list.add(target);
    target.amount += l.shortage;
    target.recipes.add(recipeName);
  }

  /// Подходящие продукты из запасов для ингредиента, самые точные первыми.
  List<PantryItem> _candidates(Ingredient ing) {
    final list = [
      for (final p in _pantry)
        if (Ingredient.nameCovers(p.tokens, ing.tokens) && ing.quantityIn(p.unit.kind, 1) != null) p,
    ];
    list.sort((a, b) => b.tokens.length.compareTo(a.tokens.length));
    return list;
  }

  /// Распределяет ингредиенты [servings] порций рецепта по запасам,
  /// уменьшая [remaining] (id продукта → остаток).
  List<NeedLine> allocate(Recipe r, double servings, Map<int, double> remaining) {
    final scale = r.ingredientScale(servings);
    final lines = <NeedLine>[];
    for (final ing in r.parsedIngredients) {
      if (!ing.tracked) continue;
      final candidates = _candidates(ing);
      if (candidates.isEmpty) {
        final kind = ing.kind!;
        final need = ing.quantityIn(kind, scale) ?? ing.amount! * scale;
        lines.add(NeedLine(ingredient: ing, need: need, kind: kind));
        continue;
      }
      // Списываем по очереди из всех подходящих продуктов, с первого.
      NeedLine? first;
      var left = 0.0;
      for (final p in candidates) {
        final need = ing.quantityIn(p.unit.kind, scale)!;
        if (first == null) {
          first = NeedLine(ingredient: ing, item: p, need: need, kind: p.unit.kind);
          left = need;
        } else if (p.unit.kind != first.kind) {
          continue;
        }
        final avail = remaining[p.id!] ?? 0;
        final take = avail < left ? avail : left;
        if (take <= 0) continue;
        remaining[p.id!] = avail - take;
        first.covered += take;
        left -= take;
        if (left <= 0) break;
      }
      lines.add(first!);
    }
    return lines;
  }

  /// Рецепты для приёма пищи, которые больше всего используют остатки продуктов.
  List<PantrySuggestion> suggestFromPantry(MealType? meal, {String query = ''}) {
    final rest = projection.remaining;
    final q = query.trim().toLowerCase();
    final words = q.isEmpty ? const <String>[] : q.split(RegExp(r'\s+'));
    final result = <PantrySuggestion>[];
    for (final r in catalog.recipes) {
      if (words.isNotEmpty) {
        if (!words.every(r.searchText.contains)) continue;
      } else if (meal != null && !r.mealTypes.contains(meal)) {
        continue;
      }
      result.add(PantrySuggestion(r, allocate(r, 1, Map.of(rest))));
    }
    // Сначала блюда из имеющихся продуктов, где меньше всего докупать.
    result.sort((a, b) {
      final usesA = a.used.isNotEmpty, usesB = b.used.isNotEmpty;
      if (usesA != usesB) return usesA ? -1 : 1;
      final missing = a.missing.compareTo(b.missing);
      if (missing != 0) return missing;
      final used = b.used.length.compareTo(a.used.length);
      return used != 0 ? used : a.recipe.name.compareTo(b.recipe.name);
    });
    return result;
  }

  Future<void> addToPlan(Recipe r, DateTime day, MealType meal, {double servings = 1}) =>
      repository.addPlanEntry(PlanEntry(
        dayKey: dayKeyOf(day),
        meal: meal,
        recipeKey: r.key,
        servings: servings,
      ));

  Future<void> setServings(PlanEntry e, double servings) =>
      repository.updatePlanEntry(e.copyWith(servings: servings));

  Future<void> removeFromPlan(PlanEntry e) => repository.deletePlanEntry(e.id!);

  /// Блюдо приготовлено: списывает продукты из запасов и отмечает в плане.
  Future<void> markCooked(PlanEntry e) async {
    final r = catalog.byKey(e.recipeKey);
    if (r != null) await consume(r, e.servings);
    await repository.updatePlanEntry(e.copyWith(done: true));
  }

  /// Списывает из запасов продукты на [servings] порций рецепта.
  Future<void> consume(Recipe r, double servings) async {
    final remaining = {for (final p in _pantry) p.id!: p.amount};
    allocate(r, servings, remaining);
    for (final p in _pantry) {
      final left = remaining[p.id!]!;
      if (left == p.amount) continue;
      if (left <= _eps(p.unit.kind)) {
        await repository.deletePantryItem(p.id!);
      } else {
        await repository.savePantryItem(p.copyWith(amount: left));
      }
    }
  }

  /// Добавляет покупку; одноимённый продукт в тех же единицах пополняется.
  Future<void> addToPantry(String name, double amount, PantryUnit unit) async {
    final tokens = Ingredient.nameTokens(Ingredient.cleanName(name));
    for (final p in _pantry) {
      if (p.unit == unit && p.tokens.length == tokens.length && Ingredient.nameCovers(p.tokens, tokens)) {
        await repository.savePantryItem(p.copyWith(amount: p.amount + amount));
        return;
      }
    }
    await repository.savePantryItem(PantryItem(name: name, amount: amount, unit: unit));
  }

  Future<void> updatePantryItem(PantryItem item) => repository.savePantryItem(item);

  Future<void> deletePantryItem(PantryItem item) => repository.deletePantryItem(item.id!);

  /// Всё из списка покупок отмечено купленным.
  Future<void> buy(ShoppingItem s) => addToPantry(_capitalize(s.name), roundUp(s.amount, s.unit), s.unit);

  static double roundUp(double amount, PantryUnit unit) => switch (unit) {
        PantryUnit.pcs => amount.ceilToDouble(),
        _ => amount <= 50 ? (amount / 5).ceil() * 5.0 : (amount / 10).ceil() * 10.0,
      };

  static String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  @override
  void dispose() {
    catalog.removeListener(_changed);
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }
}
