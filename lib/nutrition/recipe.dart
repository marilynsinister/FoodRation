import 'dart:typed_data';

import 'ingredient.dart';
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
    this.photo,
    this.customId,
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

  /// Фото своего продукта или блюда (JPEG), снятое в приложении.
  final Uint8List? photo;

  /// id в таблице своих продуктов; null для рецептов из сборников.
  final int? customId;

  bool get isCustom => customId != null;

  /// Порцию можно задать в граммах.
  bool get measuredInGrams => per100 != null && serving == null;

  late final String searchText =
      '${name.toLowerCase()} ${ingredients.join(' ').toLowerCase()}';

  late final List<Ingredient> parsedIngredients = [
    for (final i in ingredients) Ingredient.parse(i),
  ];

  /// Вес одной порции для блюд, считающихся по 100 г.
  double get servingGrams => portionG ?? 100;

  /// Сколько порций выходит из рецепта как написано.
  double get yieldServings {
    if (serving != null) return (servings ?? 1).toDouble();
    final total = totalWeightG;
    if (total == null || total <= 0) return 1;
    return total / servingGrams;
  }

  /// Во сколько раз умножить ингредиенты, чтобы приготовить [count] порций.
  double ingredientScale(double count) => count / yieldServings;

  /// «2 порции», «300 г» — подпись для количества приготовленных порций.
  String servingsLabel(double count) {
    final w = weightLabel(count);
    return w == null ? _servingsLabel(count) : '${_servingsLabel(count)} · $w';
  }

  /// Вес одной порции в граммах: из источника, по весу всего блюда или,
  /// если ничего не указано, по сумме веса ингредиентов.
  late final double? servingWeightG = () {
    if (measuredInGrams) return servingGrams;
    if (servingG != null) return servingG;
    final n = (servings ?? 1).toDouble();
    if (totalWeightG != null) return totalWeightG! / n;
    var raw = 0.0;
    for (final i in parsedIngredients) {
      raw += i.quantityIn(QtyKind.mass, 1) ?? 0;
    }
    if (raw > 0) return raw / n;
    // В источнике нет ни веса, ни количества ингредиентов — оцениваем по
    // калорийности: типичная плотность блюд сборников ≈ 135 ккал на 100 г.
    final kcal = defaultPortionMacros.kcal;
    return kcal > 0 ? kcal / _typicalKcalPer100 * 100 : null;
  }();

  static const _typicalKcalPer100 = 135.0;

  /// Вес порции оценён (по сырым ингредиентам или калорийности).
  bool get servingWeightApprox => !measuredInGrams && servingG == null && totalWeightG == null;

  /// «250 г», «≈ 500 г» — вес [count] порций.
  String? weightLabel(double count) {
    final w = servingWeightG;
    if (w == null) return null;
    final g = w * count;
    final rounded = g >= 100 ? (g / 5).round() * 5 : g.round();
    return '${servingWeightApprox ? '≈ ' : ''}$rounded г';
  }

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
        ServingsPortion(:final count) => switch (weightLabel(count)) {
            null => _servingsLabel(count),
            final w => '${_servingsLabel(count)} ($w)',
          },
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
