import 'macros.dart';

enum Sex {
  female('Женский'),
  male('Мужской');

  const Sex(this.label);

  final String label;
}

/// Коэффициенты активности из книги (гл. 20), берётся середина диапазона.
enum ActivityLevel {
  sedentary(1.2, 'Минимальная', 'Сидячая работа, почти без спорта'),
  light(1.35, 'Лёгкая', '≈3 тренировки в неделю, прогулки'),
  moderate(1.55, 'Средняя', 'Спорт ~5 раз в неделю'),
  high(1.75, 'Высокая', 'Интенсивные тренировки ежедневно'),
  extreme(1.95, 'Экстремальная', 'Тяжёлый физический труд, профессиональный спорт');

  const ActivityLevel(this.multiplier, this.label, this.description);

  final double multiplier;
  final String label;
  final String description;
}

enum Goal {
  loseWeight('Похудение', 'Дефицит 15% от нормы', -0.15, 1.8, 0.9),
  maintain('Поддержание веса', 'Калории на уровне расхода', 0, 1.4, 1.0),
  gainMuscle('Набор мышц', 'Профицит 10%, много белка', 0.10, 2.0, 1.0),
  gainMass('Набор массы', 'Профицит 20%', 0.20, 1.7, 1.1);

  const Goal(
    this.label,
    this.description,
    this.calorieAdjustment,
    this.proteinPerKg,
    this.fatPerKg,
  );

  final String label;
  final String description;

  /// Доля от суточного расхода: −0.15 = дефицит 15%.
  final double calorieAdjustment;
  final double proteinPerKg;
  final double fatPerKg;
}

class NutritionProfile {
  const NutritionProfile({
    required this.sex,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.activity,
    required this.goal,
    this.customKcal,
  });

  static const initial = NutritionProfile(
    sex: Sex.female,
    age: 30,
    heightCm: 165,
    weightKg: 65,
    activity: ActivityLevel.light,
    goal: Goal.loseWeight,
  );

  final Sex sex;
  final int age;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activity;
  final Goal goal;

  /// Ручная норма калорий (перекрывает расчёт), БЖУ пересчитываются под неё.
  final double? customKcal;

  NutritionProfile copyWith({
    Sex? sex,
    int? age,
    double? heightCm,
    double? weightKg,
    ActivityLevel? activity,
    Goal? goal,
    double? Function()? customKcal,
  }) =>
      NutritionProfile(
        sex: sex ?? this.sex,
        age: age ?? this.age,
        heightCm: heightCm ?? this.heightCm,
        weightKg: weightKg ?? this.weightKg,
        activity: activity ?? this.activity,
        goal: goal ?? this.goal,
        customKcal: customKcal != null ? customKcal() : this.customKcal,
      );
}

class KbjuResult {
  const KbjuResult({
    required this.bmr,
    required this.tdee,
    required this.target,
    required this.limitedByBmr,
  });

  /// Базовый обмен (Миффлин — Сан Жеор).
  final double bmr;

  /// Суточный расход с учётом активности.
  final double tdee;

  /// Дневная цель КБЖУ.
  final Macros target;

  /// Дефицит упёрся в базовый обмен — ниже есть небезопасно.
  final bool limitedByBmr;
}

/// Калории на грамм, как в книге (гл. 20).
const kcalPerGramProtein = 4.1;
const kcalPerGramFat = 9.3;
const kcalPerGramCarb = 4.1;

KbjuResult calculateKbju(NutritionProfile p) {
  final base = 9.99 * p.weightKg + 6.25 * p.heightCm - 4.92 * p.age;
  final bmr = p.sex == Sex.male ? base + 5 : base - 161;
  final tdee = bmr * p.activity.multiplier;

  var kcal = p.customKcal ?? tdee * (1 + p.goal.calorieAdjustment);
  var limited = false;
  if (p.customKcal == null && kcal < bmr) {
    kcal = bmr;
    limited = true;
  }

  final protein = p.goal.proteinPerKg * p.weightKg;
  var fat = p.goal.fatPerKg * p.weightKg;
  var carbs = (kcal - protein * kcalPerGramProtein - fat * kcalPerGramFat) / kcalPerGramCarb;
  final minCarbs = p.weightKg * 1.5;
  if (carbs < minCarbs) {
    fat = (fat * 0.75).clamp(0.6 * p.weightKg, fat);
    carbs = (kcal - protein * kcalPerGramProtein - fat * kcalPerGramFat) / kcalPerGramCarb;
  }
  if (carbs < 0) carbs = 0;

  return KbjuResult(
    bmr: bmr,
    tdee: tdee,
    target: Macros(
      kcal: kcal.roundToDouble(),
      protein: protein.roundToDouble(),
      fat: fat.roundToDouble(),
      carbs: carbs.roundToDouble(),
    ),
    limitedByBmr: limited,
  );
}
