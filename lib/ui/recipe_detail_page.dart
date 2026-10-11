import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/ui/charts.dart';
import 'package:food_ration/ui/macro_widgets.dart';
import 'package:food_ration/ui/recipe_image.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({
    super.key,
    required this.controller,
    required this.recipe,
    this.initialPortion,
    this.initialMeal,
  });

  final NutritionController controller;
  final Recipe recipe;
  final Portion? initialPortion;
  final MealType? initialMeal;

  static Future<void> open(
    BuildContext context,
    NutritionController controller,
    Recipe recipe, {
    Portion? portion,
    MealType? meal,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => RecipeDetailPage(
            controller: controller,
            recipe: recipe,
            initialPortion: portion,
            initialMeal: meal,
          ),
        ),
      );

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Portion _portion = widget.initialPortion ?? widget.recipe.defaultPortion;
  late MealType _meal = widget.initialMeal ??
      (widget.recipe.mealTypes.isNotEmpty
          ? _preferred(widget.recipe.mealTypes)
          : widget.controller.defaultMealNow());
  bool _saving = false;

  MealType _preferred(List<MealType> types) {
    final now = widget.controller.defaultMealNow();
    return types.contains(now) ? now : types.first;
  }

  void _changePortion(int direction) {
    setState(() {
      _portion = switch (_portion) {
        GramsPortion(:final grams) => Portion.grams(math.max(10, grams + 10 * direction)),
        ServingsPortion(:final count) => Portion.servings(math.max(0.5, count + 0.5 * direction)),
      };
    });
  }

  Future<void> _log() async {
    setState(() => _saving = true);
    await widget.controller.logRecipe(widget.recipe, _portion, _meal);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '«${widget.recipe.name}» (${widget.recipe.portionLabel(_portion)}) '
          'добавлено в ${_meal.label.toLowerCase()}',
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    final theme = Theme.of(context);
    final portionMacros = r.macrosFor(_portion);
    return Scaffold(
      appBar: AppBar(title: Text(r.name, maxLines: 2)),
      body: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) {
          final day = widget.controller.day;
          final after = day == null ? null : day.target - day.eaten - portionMacros;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              RecipeImage(recipe: r, height: 220, borderRadius: 16),
              const SizedBox(height: 12),
              Text(r.name, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                [r.book, r.category, if (r.page != null) 'стр. ${r.page}'].join(' · '),
                style: theme.textTheme.bodySmall,
              ),
              if (r.note != null) ...[
                const SizedBox(height: 4),
                Text(r.note!, style: theme.textTheme.bodySmall),
              ],
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      MacroDonut(
                        macros: portionMacros,
                        size: 96,
                        center: Text(
                          '${portionMacros.kcal.round()}\nккал',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: MacroLegend(macros: portionMacros)),
                    ],
                  ),
                ),
              ),
              if (r.per100 != null || r.serving != null || r.totalWeightG != null) ...[
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (r.per100 != null) ...[
                          Text('На 100 г', style: theme.textTheme.labelMedium),
                          MacroLine(r.per100!),
                          const SizedBox(height: 8),
                        ],
                        if (r.serving != null) ...[
                          Text(
                            'На ${r.servingLabel ?? 'порцию'}'
                            '${r.servingG != null ? ' (~${r.servingG!.round()} г)' : ''}',
                            style: theme.textTheme.labelMedium,
                          ),
                          MacroLine(r.serving!),
                          const SizedBox(height: 8),
                        ],
                        if (r.totalWeightG != null)
                          Text(
                            'Вес всего блюда ≈ ${r.totalWeightG!.round()} г',
                            style: theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text('Сколько съели', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton.filledTonal(
                    key: const Key('portion-minus'),
                    onPressed: () => _changePortion(-1),
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Text(
                      r.portionLabel(_portion),
                      key: const Key('portion-label'),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  IconButton.filledTonal(
                    key: const Key('portion-plus'),
                    onPressed: () => _changePortion(1),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Center(child: MacroLine(portionMacros, style: theme.textTheme.bodyLarge)),
              if (after != null) ...[
                const SizedBox(height: 8),
                _AfterHint(after: after),
              ],
              const SizedBox(height: 16),
              SegmentedButton<MealType>(
                segments: [
                  for (final m in MealType.values)
                    ButtonSegment(value: m, label: Text(m.label, overflow: TextOverflow.ellipsis)),
                ],
                selected: {_meal},
                showSelectedIcon: false,
                onSelectionChanged: (s) => setState(() => _meal = s.first),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                key: const Key('log-recipe'),
                onPressed: _saving ? null : _log,
                icon: const Icon(Icons.check),
                label: const Text('Сегодня приготовила и съела'),
              ),
              const SizedBox(height: 24),
              Text('Ингредиенты', style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              for (final i in r.ingredients)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('• $i'),
                ),
              if (r.steps.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Приготовление', style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                for (var i = 0; i < r.steps.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('${i + 1}. ${r.steps[i]}'),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _AfterHint extends StatelessWidget {
  const _AfterHint({required this.after});

  final Macros after;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overKcal = after.kcal < -25;
    final overParts = [
      if (after.fat < -3) 'жиры на ${(-after.fat).round()} г',
      if (after.carbs < -5) 'углеводы на ${(-after.carbs).round()} г',
    ];
    final String text;
    final Color color;
    if (overKcal) {
      text = 'Норма калорий будет превышена на ${(-after.kcal).round()} ккал';
      color = theme.colorScheme.error;
    } else if (overParts.isNotEmpty) {
      text = 'Останется ${after.kcal.round()} ккал, но превысите ${overParts.join(' и ')}';
      color = Colors.orange.shade800;
    } else {
      text = 'После этого останется ${after.kcal.round()} ккал · '
          'Б ${after.protein.round()} · Ж ${after.fat.round()} · У ${after.carbs.round()}';
      color = Colors.green.shade700;
    }
    return Text(
      text,
      key: const Key('after-hint'),
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium?.copyWith(color: color),
    );
  }
}
