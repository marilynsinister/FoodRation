import 'dart:math' as math;

import 'macros.dart';
import 'recipe.dart';

/// Доля дневной нормы на каждый приём пищи.
const mealShares = {
  MealType.breakfast: 0.25,
  MealType.lunch: 0.35,
  MealType.snack: 0.15,
  MealType.dinner: 0.25,
};

class Suggestion {
  const Suggestion({
    required this.recipe,
    required this.portion,
    required this.macros,
    required this.score,
  });

  final Recipe recipe;
  final Portion portion;
  final Macros macros;

  /// Меньше — лучше.
  final double score;
}

class PlanItem {
  const PlanItem(this.meal, this.suggestion);

  final MealType meal;
  final Suggestion suggestion;
}

class DayContext {
  const DayContext({
    required this.target,
    required this.eaten,
    required this.loggedMeals,
    this.eatenRecipeKeys = const {},
  });

  final Macros target;
  final Macros eaten;

  /// Приёмы пищи, по которым уже есть записи сегодня.
  final Set<MealType> loggedMeals;
  final Set<String> eatenRecipeKeys;

  Macros get remaining => (target - eaten).clampNonNegative();

  List<MealType> get remainingMeals =>
      [for (final m in MealType.values) if (!loggedMeals.contains(m)) m];

  /// Следующий приём пищи по порядку (или перекус, если всё уже отмечено).
  MealType get nextMeal {
    final left = remainingMeals;
    return left.isEmpty ? MealType.snack : left.first;
  }

  /// Сколько калорий отвести на [meal] из оставшихся.
  double budgetFor(MealType meal) =>
      Recommender._budget(target, meal, remaining, remainingMeals);
}

class Recommender {
  Recommender(this.recipes);

  final List<Recipe> recipes;

  static const _kcalTolerance = 25.0;

  /// Порция [recipe] под бюджет [budget] ккал, не выходящая за [remaining].
  /// `null`, если блюдо не помещается даже в минимальной порции.
  static Suggestion? fit(
    Recipe recipe, {
    required double budget,
    required Macros remaining,
    bool repeat = false,
  }) {
    Portion? portion;
    final maxKcal = remaining.kcal + _kcalTolerance;
    if (recipe.measuredInGrams) {
      final k100 = recipe.per100!.kcal;
      if (k100 <= 0) return null;
      final base = recipe.portionG ?? 150;
      // За один приём нельзя съесть больше, чем получается по рецепту.
      final whole = recipe.totalWeightG ?? double.infinity;
      final minG = math.min(math.max(base * 0.5, 40.0), whole);
      final maxG = [base * 1.5, whole, maxKcal / k100 * 100].reduce(math.min);
      if (maxG < minG) return null;
      final ideal = budget / k100 * 100;
      final grams = (ideal.clamp(minG, maxG) / 10).floorToDouble() * 10;
      portion = Portion.grams(grams < minG ? minG.roundToDouble() : grams);
    } else {
      final perOne = recipe.serving!.kcal;
      if (perOne <= 0) return null;
      final pieces = recipe.servingLabel == '1 шт';
      final options = pieces
          ? [for (var i = 1; i <= math.max(1, recipe.servings ?? 1); i++) i.toDouble()]
          : const [0.5, 1.0, 1.5];
      double? best;
      for (final o in options) {
        if (perOne * o > maxKcal) continue;
        if (best == null || (perOne * o - budget).abs() < (perOne * best - budget).abs()) {
          best = o;
        }
      }
      if (best == null) return null;
      portion = Portion.servings(best);
    }
    final m = recipe.macrosFor(portion);
    if (m.kcal > maxKcal) return null;
    return Suggestion(
      recipe: recipe,
      portion: portion,
      macros: m,
      score: _score(m, remaining, budget) + (repeat ? 0.6 : 0),
    );
  }

  static double _score(Macros m, Macros r, double budget) {
    double rel(double a, double b) => (a - b).abs() / math.max(b, 5);
    double over(double a, double b) => a > b ? (a - b) / math.max(b, 5) : 0;

    final f = r.kcal > 0 ? m.kcal / r.kcal : 1.0;
    final shape = 1.5 * rel(m.protein, r.protein * f) +
        rel(m.fat, r.fat * f) +
        rel(m.carbs, r.carbs * f);
    final overflow = 3 *
        (over(m.protein * 0.5, r.protein) + over(m.fat, r.fat) + over(m.carbs, r.carbs));
    final kcalFit = (m.kcal - budget).abs() / math.max(budget, 100);
    return shape + overflow + 1.2 * kcalFit;
  }

  /// Блюда для [meal], отсортированные по тому, насколько хорошо они
  /// закрывают остаток КБЖУ.
  List<Suggestion> suggest(
    DayContext day,
    MealType meal, {
    int limit = 20,
    List<MealType>? mealsLeft,
    Macros? remainingOverride,
    Set<String> exclude = const {},
  }) {
    final remaining = remainingOverride ?? day.remaining;
    if (remaining.kcal < 60) return const [];
    final budget = _budget(day.target, meal, remaining, mealsLeft ?? day.remainingMeals);
    final out = <Suggestion>[];
    for (final r in recipes) {
      if (!r.mealTypes.contains(meal) || exclude.contains(r.key)) continue;
      final s = fit(
        r,
        budget: budget,
        remaining: remaining,
        repeat: day.eatenRecipeKeys.contains(r.key),
      );
      if (s != null) out.add(s);
    }
    out.sort((a, b) => a.score.compareTo(b.score));
    return out.take(limit).toList();
  }

  static double _budget(Macros target, MealType meal, Macros remaining, List<MealType> left) {
    if (!left.contains(meal)) {
      // Дополнительный приём: не больше обычной доли перекуса от нормы.
      return math.min(remaining.kcal, target.kcal * mealShares[MealType.snack]!);
    }
    final total = left.fold<double>(0, (s, m) => s + mealShares[m]!);
    return remaining.kcal * mealShares[meal]! / total;
  }

  /// Жадный план на оставшиеся приёмы пищи. [variant] перебирает
  /// альтернативы среди лучших кандидатов.
  List<PlanItem> planRestOfDay(DayContext day, {int variant = 0}) {
    final left = day.remainingMeals;
    var remaining = day.remaining;
    final used = <String>{...day.eatenRecipeKeys};
    final plan = <PlanItem>[];
    final rnd = math.Random(variant);
    for (var i = 0; i < left.length; i++) {
      final meal = left[i];
      final options = suggest(
        day,
        meal,
        limit: 5,
        mealsLeft: left.sublist(i),
        remainingOverride: remaining,
        exclude: used,
      );
      if (options.isEmpty) continue;
      final pick = variant == 0 ? options.first : options[rnd.nextInt(options.length)];
      plan.add(PlanItem(meal, pick));
      used.add(pick.recipe.key);
      remaining = (remaining - pick.macros).clampNonNegative();
    }
    return plan;
  }
}
