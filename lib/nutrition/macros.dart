/// Калории и БЖУ (г).
class Macros {
  const Macros({
    required this.kcal,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  static const zero = Macros(kcal: 0, protein: 0, fat: 0, carbs: 0);

  factory Macros.fromList(List<dynamic> v) => Macros(
        kcal: (v[0] as num).toDouble(),
        protein: (v[1] as num).toDouble(),
        fat: (v[2] as num).toDouble(),
        carbs: (v[3] as num).toDouble(),
      );

  final double kcal;
  final double protein;
  final double fat;
  final double carbs;

  Macros operator +(Macros o) => Macros(
        kcal: kcal + o.kcal,
        protein: protein + o.protein,
        fat: fat + o.fat,
        carbs: carbs + o.carbs,
      );

  Macros operator -(Macros o) => Macros(
        kcal: kcal - o.kcal,
        protein: protein - o.protein,
        fat: fat - o.fat,
        carbs: carbs - o.carbs,
      );

  Macros operator *(double k) => Macros(
        kcal: kcal * k,
        protein: protein * k,
        fat: fat * k,
        carbs: carbs * k,
      );

  Macros clampNonNegative() => Macros(
        kcal: kcal < 0 ? 0 : kcal,
        protein: protein < 0 ? 0 : protein,
        fat: fat < 0 ? 0 : fat,
        carbs: carbs < 0 ? 0 : carbs,
      );

  /// «320 ккал · Б 25 · Ж 10 · У 30»
  String format() => '${kcal.round()} ккал · Б ${protein.round()} · '
      'Ж ${fat.round()} · У ${carbs.round()}';
}
