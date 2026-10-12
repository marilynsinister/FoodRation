import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/ingredient.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/planner/planner_controller.dart';
import 'package:food_ration/ui/app_scope.dart';
import 'package:food_ration/ui/charts.dart';
import 'package:food_ration/ui/macro_widgets.dart';
import 'package:food_ration/ui/own_food_sheet.dart';
import 'package:food_ration/ui/plan_add_sheet.dart';
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
    final planner = AppScope.plannerOf(context);
    final recipe = widget.recipe;
    final cook = _cookServings;
    final usesPantry = planner != null &&
        planner
            .allocate(recipe, cook, {for (final p in planner.pantry) p.id!: p.amount})
            .any((l) => l.covered > 0);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '«${recipe.name}» (${recipe.portionLabel(_portion)}) '
          'добавлено в ${_meal.label.toLowerCase()}',
        ),
        action: usesPantry
            ? SnackBarAction(
                label: 'Списать продукты',
                onPressed: () => planner.consume(recipe, cook),
              )
            : null,
      ),
    );
    Navigator.of(context).pop();
  }

  /// Ввод точного веса (или числа порций) съеденного.
  Future<void> _enterPortion() async {
    final grams = _portion is GramsPortion;
    final text = TextEditingController(
      text: switch (_portion) {
        GramsPortion(:final grams) => grams.round().toString(),
        ServingsPortion(:final count) => count.toString().replaceAll('.0', ''),
      },
    );
    final value = await showDialog<double>(
      context: context,
      builder: (ctx) {
        void submit() {
          final v = double.tryParse(text.text.replaceAll(',', '.').trim());
          if (v != null && v > 0) Navigator.pop(ctx, v);
        }

        return AlertDialog(
          title: Text(grams ? 'Сколько граммов съели' : 'Сколько порций съели'),
          content: TextField(
            key: const Key('portion-input'),
            controller: text,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(suffixText: grams ? 'г' : 'порц.'),
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
            FilledButton(onPressed: submit, child: const Text('OK')),
          ],
        );
      },
    );
    text.dispose();
    if (value == null) return;
    setState(() => _portion = grams ? Portion.grams(value) : Portion.servings(value));
  }

  /// Сколько порций готовим — на это число пересчитываются ингредиенты.
  double _cookServings = 1;

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    final theme = Theme.of(context);
    final portionMacros = r.macrosFor(_portion);
    return Scaffold(
      appBar: AppBar(
        title: Text(r.name, maxLines: 2),
        actions: [
          if (r.customId != null)
            IconButton(
              tooltip: 'Изменить',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () async {
                await editCustomRecipe(context, widget.controller, r.customId!);
                // Продукт мог измениться или быть удалён — карточка устарела.
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
        ],
      ),
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
                            '${r.weightLabel(1) != null ? ' (${r.weightLabel(1)})' : ''}',
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
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: _enterPortion,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          children: [
                            Text(
                              r.portionLabel(_portion),
                              key: const Key('portion-label'),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge,
                            ),
                            Text('нажмите, чтобы ввести точно', style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
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
              _IngredientsSection(
                recipe: r,
                servings: _cookServings,
                meal: _meal,
                onServingsChanged: (v) => setState(() => _cookServings = v),
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
      color = theme.brightness == Brightness.dark ? Colors.orange.shade300 : Colors.orange.shade800;
    } else {
      text = 'После этого останется ${after.kcal.round()} ккал · '
          'Б ${after.protein.round()} · Ж ${after.fat.round()} · У ${after.carbs.round()}';
      color = theme.brightness == Brightness.dark ? Colors.green.shade300 : Colors.green.shade700;
    }
    return Text(
      text,
      key: const Key('after-hint'),
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium?.copyWith(color: color),
    );
  }
}

/// Ингредиенты, пересчитанные на нужное число порций, с отметками запасов.
class _IngredientsSection extends StatelessWidget {
  const _IngredientsSection({
    required this.recipe,
    required this.servings,
    required this.meal,
    required this.onServingsChanged,
  });

  final Recipe recipe;
  final double servings;
  final MealType meal;
  final ValueChanged<double> onServingsChanged;

  @override
  Widget build(BuildContext context) {
    final planner = AppScope.plannerOf(context);
    if (planner == null) return _build(context, null, null);
    return ListenableBuilder(
      listenable: planner,
      builder: (context, _) => _build(
        context,
        planner,
        planner.pantry.isEmpty
            ? null
            : {
                for (final l in planner.allocate(recipe, servings, Map.of(planner.projection.remaining)))
                  l.ingredient: l,
              },
      ),
    );
  }

  Widget _build(BuildContext context, PlannerController? planner, Map<Ingredient, NeedLine>? stock) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final ok = dark ? Colors.green.shade300 : Colors.green.shade700;
    final partial = dark ? Colors.orange.shade300 : Colors.orange.shade800;
    final scale = recipe.ingredientScale(servings);
    final whole = recipe.yieldServings;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ингредиенты', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('Готовлю:', style: theme.textTheme.bodyLarge),
            const SizedBox(width: 8),
            IconButton.outlined(
              key: const Key('cook-minus'),
              visualDensity: VisualDensity.compact,
              onPressed: servings <= 1
                  ? null
                  : () => onServingsChanged(math.max(1, (servings - 1).ceilToDouble())),
              icon: const Icon(Icons.remove),
            ),
            Expanded(
              child: Text(
                recipe.servingsLabel(servings),
                key: const Key('cook-label'),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ),
            IconButton.outlined(
              key: const Key('cook-plus'),
              visualDensity: VisualDensity.compact,
              onPressed: () => onServingsChanged((servings + 1).floorToDouble()),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        if ((whole - servings).abs() > 0.05)
          Align(
            alignment: Alignment.centerLeft,
            child: ActionChip(
              avatar: const Icon(Icons.restaurant, size: 18),
              label: Text('Как в рецепте: ${_count(whole)} порц.'),
              onPressed: () => onServingsChanged(whole),
            ),
          ),
        const SizedBox(height: 4),
        for (final i in recipe.parsedIngredients)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text('• ${i.scaled(scale)}')),
                if (stock?[i] case final NeedLine l when l.item != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Tooltip(
                      message: 'В запасах: ${l.item!.name}',
                      child: Icon(
                        l.isShort ? Icons.remove_circle_outline : Icons.check_circle_outline,
                        size: 18,
                        color: l.isShort ? partial : ok,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        if (stock != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Значки — продукты из ваших запасов: ✓ хватает, ⊖ не хватает (с учётом блюд в плане).',
              style: theme.textTheme.bodySmall,
            ),
          ),
        if (planner != null) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                key: const Key('add-to-plan'),
                onPressed: () async {
                  final added = await showAddToPlanSheet(
                    context,
                    planner: planner,
                    recipe: recipe,
                    servings: servings,
                    meal: meal,
                  );
                  if (added && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('«${recipe.name}» добавлено в план')),
                    );
                  }
                },
                icon: const Icon(Icons.event_note_outlined),
                label: const Text('В план'),
              ),
              if (stock != null)
                TextButton.icon(
                  key: const Key('consume-now'),
                  onPressed: () async {
                    await planner.consume(recipe, servings);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Продукты на ${recipe.servingsLabel(servings)} списаны из запасов'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.kitchen_outlined),
                  label: const Text('Списать из запасов'),
                ),
            ],
          ),
        ],
      ],
    );
  }

  static String _count(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1).replaceAll('.', ',');
}
