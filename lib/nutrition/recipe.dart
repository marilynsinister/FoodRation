import 'macros.dart';

enum MealType {
  breakfast('Завтрак'),
  lunch('Обед'),
  snack('Перекус'),
  dinner('Ужин');

  const MealType(this.label);

  final String label;

  static MealType? tryParse(String? code) {
    for (final m in values) {
      if (m.name == code) return m;
    }
    return null;
  }
}

/// Рецепт из сборников (assets/recipes/recipes.json, см. tool/extract_recipes.py).
class Recipe {
  Recipe({
    required this.key,
    required this.name,
    required this.book,
    required this.category,
    required this.mealTypes,
    required this.ingredients,
    required this.steps,
    this.page,
    this.per100,
    this.portionG,
    this.serving,
    this.servingG,
    this.servingLabel,
    this.servings,
    this.totalWeightG,
    this.note,
    this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> j) {
    Macros? m(String k) => j[k] == null ? null : Macros.fromList(j[k] as List);
    double? d(String k) => (j[k] as num?)?.toDouble();
    return Recipe(
      key: j['key'] as String,
      name: j['name'] as String,
      book: j['book'] as String,
      category: j['category'] as String,
      mealTypes: [
        for (final c in (j['mealTypes'] as List? ?? const [])) ?MealType.tryParse(c as String),
      ],
      ingredients: [for (final s in j['ingredients'] as List? ?? const []) s as String],
      steps: [for (final s in j['steps'] as List? ?? const []) s as String],
      page: j['page'] as int?,
      per100: m('per100'),
      portionG: d('portionG'),
      serving: m('serving'),
      servingG: d('servingG'),
      servingLabel: j['servingLabel'] as String?,
      servings: (j['servings'] as num?)?.toInt(),
      totalWeightG: d('totalWeightG'),
      note: j['note'] as String?,
      image: j['image'] as String?,
    );
  }

  final String key;
  final String name;
  final String book;
  final String category;

  /// Пустой список — блюдо не предлагается автоматически (соусы, кремы).
  final List<MealType> mealTypes;
  final List<String> ingredients;
  final List<String> steps;
  final int? page;

  /// КБЖУ на 100 г готового блюда, если известно.
  final Macros? per100;

  /// Рекомендуемая порция в граммах (для рецептов с [per100]).
  final double? portionG;

  /// КБЖУ одной порции, если в источнике указано на порцию / на всё блюдо.
  final Macros? serving;
  final double? servingG;
  final String? servingLabel;
  final int? servings;
  final double? totalWeightG;
  final String? note;

  /// Путь к фото в ассетах, например `assets/recipe_images/{key}.jpg`.
  final String? image;

  /// Порцию можно задать в граммах.
  bool get measuredInGrams => per100 != null && serving == null;

  late final String searchText =
      '${name.toLowerCase()} ${ingredients.join(' ').toLowerCase()}';

  /// КБЖУ стандартной порции.
  Macros get defaultPortionMacros =>
      serving ?? per100! * ((portionG ?? 100) / 100);

  Portion get defaultPortion => measuredInGrams
      ? Portion.grams(portionG ?? 100)
      : const Portion.servings(1);

  Macros macrosFor(Portion p) => switch (p) {
        GramsPortion(:final grams) => per100! * (grams / 100),
        ServingsPortion(:final count) => (serving ?? defaultPortionMacros) * count,
      };

  String portionLabel(Portion p) => switch (p) {
        GramsPortion(:final grams) => '${grams.round()} г',
        ServingsPortion(:final count) => _servingsLabel(count),
      };

  String _servingsLabel(double count) {
    final unit = servingLabel ?? 'порция';
    final n = count == count.roundToDouble()
        ? count.toInt().toString()
        : count.toStringAsFixed(1).replaceAll('.', ',');
    if (unit.startsWith('порция')) {
      final suffix = unit.substring('порция'.length);
      if (count == 0.5) return '½ порции$suffix';
      return '$n ${count == 1 ? 'порция' : count < 5 ? 'порции' : 'порций'}$suffix';
    }
    return '$n × $unit';
  }
}

sealed class Portion {
  const Portion();

  const factory Portion.grams(double grams) = GramsPortion;

  const factory Portion.servings(double count) = ServingsPortion;
}

class GramsPortion extends Portion {
  const GramsPortion(this.grams);

  final double grams;
}

class ServingsPortion extends Portion {
  const ServingsPortion(this.count);

  final double count;
}
