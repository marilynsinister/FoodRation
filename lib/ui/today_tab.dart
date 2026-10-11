import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/nutrition_repository.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/nutrition/recommender.dart';
import 'package:food_ration/ui/charts.dart';
import 'package:food_ration/ui/macro_widgets.dart';
import 'package:food_ration/ui/recipe_detail_page.dart';
import 'package:food_ration/ui/recipe_image.dart';

class TodayTab extends StatefulWidget {
  const TodayTab({super.key, required this.controller, required this.onOpenProfile});

  final NutritionController controller;
  final VoidCallback onOpenProfile;

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  MealType? _meal;
  int _planVariant = 0;
  bool _showAll = false;

  NutritionController get c => widget.controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: c,
      builder: (context, _) {
        if (!c.loaded) return const Center(child: CircularProgressIndicator());
        c.ensureToday();
        final day = c.day;
        if (day == null) return _NoProfile(onOpenProfile: widget.onOpenProfile);
        final meal = _meal ?? day.nextMeal;
        final plan = day.remaining.kcal < 60
            ? const <PlanItem>[]
            : c.recommender.planRestOfDay(day, variant: _planVariant);
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _SummaryCard(
              day: day,
              goalLabel: c.profile!.goal.label,
              eatenByMeal: {
                for (final m in MealType.values)
                  m: c.entries.where((e) => e.meal == m).fold(0.0, (s, e) => s + e.macros.kcal),
              },
              plannedByMeal: {for (final p in plan) p.meal: p.suggestion.macros.kcal},
            ),
            const SizedBox(height: 16),
            _DiarySection(controller: c),
            const SizedBox(height: 24),
            if (day.remaining.kcal < 60)
              const _DoneCard()
            else ...[
              _SuggestionsSection(
                controller: c,
                day: day,
                meal: meal,
                showAll: _showAll,
                onMealChanged: (m) => setState(() {
                  _meal = m;
                  _showAll = false;
                }),
                onShowAll: () => setState(() => _showAll = true),
              ),
              const SizedBox(height: 24),
              _PlanSection(
                controller: c,
                day: day,
                plan: plan,
                onAnother: () => setState(() => _planVariant++),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _NoProfile extends StatelessWidget {
  const _NoProfile({required this.onOpenProfile});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calculate_outlined, size: 56),
            const SizedBox(height: 12),
            Text(
              'Сначала рассчитайте свою норму КБЖУ',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Приложение подберёт рецепты из сборников так, чтобы за день '
              'уложиться в калории и БЖУ под вашу цель.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onOpenProfile, child: const Text('Открыть калькулятор')),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.day,
    required this.goalLabel,
    required this.eatenByMeal,
    required this.plannedByMeal,
  });

  final DayContext day;
  final String goalLabel;
  final Map<MealType, double> eatenByMeal;
  final Map<MealType, double> plannedByMeal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final left = day.target.kcal - day.eaten.kcal;
    double ratio(double v, double max) => max <= 0 ? 0 : v / max;
    Widget macroRing(String label, double v, double max, Color color) => Column(
          children: [
            RingProgress(
              value: ratio(v, max),
              color: color,
              size: 58,
              stroke: 7,
              center: Text(
                '${(ratio(v, max) * 100).round()}%',
                style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: theme.textTheme.labelMedium),
            Text('${v.round()}/${max.round()} г', style: theme.textTheme.bodySmall),
          ],
        );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Цель: $goalLabel', style: theme.textTheme.labelLarge),
            const SizedBox(height: 12),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
              children: [
                RingProgress(
                  value: ratio(day.eaten.kcal, day.target.kcal),
                  color: MacroColors.kcal,
                  size: 128,
                  stroke: 13,
                  center: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${left.abs().round()}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: left < 0 ? theme.colorScheme.error : null,
                        ),
                      ),
                      Text(
                        left >= 0 ? 'осталось' : 'перебор',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    macroRing('Белки', day.eaten.protein, day.target.protein, MacroColors.protein),
                    const SizedBox(width: 12),
                    macroRing('Жиры', day.eaten.fat, day.target.fat, MacroColors.fat),
                    const SizedBox(width: 12),
                    macroRing('Углев.', day.eaten.carbs, day.target.carbs, MacroColors.carbs),
                  ],
                ),
              ],
            ),
            ),
            const SizedBox(height: 12),
            Text(
              left >= 0 ? 'Осталось ${left.round()} ккал' : 'Перебор ${(-left).round()} ккал',
              key: const Key('kcal-left'),
              style: theme.textTheme.titleMedium?.copyWith(
                color: left < 0 ? theme.colorScheme.error : null,
              ),
            ),
            Text(
              'Съедено ${day.eaten.kcal.round()} из ${day.target.kcal.round()} ккал',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Text('Калории по приёмам пищи (бледным — план)', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            MealDistributionBar(
              target: day.target.kcal,
              eaten: eatenByMeal,
              planned: plannedByMeal,
            ),
          ],
        ),
      ),
    );
  }
}

class _DiarySection extends StatelessWidget {
  const _DiarySection({required this.controller});

  final NutritionController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = controller.entries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('Съедено сегодня', style: theme.textTheme.titleMedium)),
            TextButton.icon(
              onPressed: () => _addCustom(context),
              icon: const Icon(Icons.add),
              label: const Text('Вручную'),
            ),
          ],
        ),
        if (entries.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Пока пусто. Откройте рецепт и отметьте «Сегодня приготовила и съела».',
            ),
          ),
        for (final m in MealType.values)
          if (entries.any((e) => e.meal == m)) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 2),
              child: Text(m.label, style: theme.textTheme.labelLarge),
            ),
            for (final e in entries.where((e) => e.meal == m)) _EntryTile(controller: controller, entry: e),
          ],
      ],
    );
  }

  Future<void> _addCustom(BuildContext context) async {
    final result = await showDialog<(String, Macros, MealType)>(
      context: context,
      builder: (_) => _CustomEntryDialog(initialMeal: controller.defaultMealNow()),
    );
    if (result != null) await controller.logCustom(result.$1, result.$2, result.$3);
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({required this.controller, required this.entry});

  final NutritionController controller;
  final DiaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final recipe = entry.recipeKey == null ? null : controller.catalog.byKey(entry.recipeKey!);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        dense: true,
        leading: recipe == null
            ? const CircleAvatar(child: Icon(Icons.restaurant))
            : RecipeImage(recipe: recipe, width: 52, height: 52, borderRadius: 8, cacheWidth: 104),
        title: Text(entry.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (entry.portionLabel != null) Text(entry.portionLabel!),
            MacroLine(entry.macros),
          ],
        ),
        onTap: recipe == null ? null : () => RecipeDetailPage.open(context, controller, recipe),
        trailing: IconButton(
          tooltip: 'Удалить',
          icon: const Icon(Icons.delete_outline),
          onPressed: () => controller.deleteEntry(entry),
        ),
      ),
    );
  }
}

class _SuggestionsSection extends StatelessWidget {
  const _SuggestionsSection({
    required this.controller,
    required this.day,
    required this.meal,
    required this.showAll,
    required this.onMealChanged,
    required this.onShowAll,
  });

  final NutritionController controller;
  final DayContext day;
  final MealType meal;
  final bool showAll;
  final ValueChanged<MealType> onMealChanged;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = controller.recommender.suggest(day, meal, limit: showAll ? 30 : 5);
    final budget = day.budgetFor(meal);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Что ещё можно приготовить', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final m in MealType.values)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(m.label),
                    selected: m == meal,
                    onSelected: (_) => onMealChanged(m),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'На ${meal.label.toLowerCase()} ≈ ${budget.round()} ккал. Порции подобраны так, '
          'чтобы остаток БЖУ распределился равномерно.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        if (list.isEmpty)
          const Text('Нет блюд, которые помещаются в оставшиеся калории.'),
        for (final s in list) SuggestionTile(controller: controller, suggestion: s, meal: meal),
        if (!showAll && list.length == 5)
          TextButton(onPressed: onShowAll, child: const Text('Показать больше вариантов')),
      ],
    );
  }
}

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({
    super.key,
    required this.controller,
    required this.suggestion,
    required this.meal,
    this.badge,
  });

  final NutritionController controller;
  final Suggestion suggestion;
  final MealType meal;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final r = suggestion.recipe;
    return RecipeListCard(
      recipe: r,
      badge: badge,
      subtitle: '${r.portionLabel(suggestion.portion)} · ${r.book}',
      macros: suggestion.macros,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => RecipeDetailPage.open(
        context,
        controller,
        r,
        portion: suggestion.portion,
        meal: meal,
      ),
    );
  }
}

class _PlanSection extends StatelessWidget {
  const _PlanSection({
    required this.controller,
    required this.day,
    required this.plan,
    required this.onAnother,
  });

  final NutritionController controller;
  final DayContext day;
  final List<PlanItem> plan;
  final VoidCallback onAnother;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (plan.isEmpty) return const SizedBox.shrink();
    final total = plan.fold(day.eaten, (Macros s, p) => s + p.suggestion.macros);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('План на остаток дня', style: theme.textTheme.titleMedium)),
            TextButton.icon(
              key: const Key('plan-another'),
              onPressed: onAnother,
              icon: const Icon(Icons.refresh),
              label: const Text('Другой вариант'),
            ),
          ],
        ),
        for (final p in plan)
          SuggestionTile(
            controller: controller,
            suggestion: p.suggestion,
            meal: p.meal,
            badge: p.meal.label,
          ),
        const SizedBox(height: 8),
        Text('Итого за день получится:', style: theme.textTheme.labelLarge),
        MacroLine(total, style: theme.textTheme.bodyMedium),
        Text(
          'Норма: ${day.target.format()}',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _DoneCard extends StatelessWidget {
  const _DoneCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Норма калорий на сегодня выполнена. Если голодно — выбирайте овощи '
          'и напитки без калорий.',
        ),
      ),
    );
  }
}

class _CustomEntryDialog extends StatefulWidget {
  const _CustomEntryDialog({required this.initialMeal});

  final MealType initialMeal;

  @override
  State<_CustomEntryDialog> createState() => _CustomEntryDialogState();
}

class _CustomEntryDialogState extends State<_CustomEntryDialog> {
  final _title = TextEditingController();
  final _kcal = TextEditingController();
  final _p = TextEditingController();
  final _f = TextEditingController();
  final _c = TextEditingController();
  late MealType _meal = widget.initialMeal;

  double _num(TextEditingController t) => double.tryParse(t.text.replaceAll(',', '.')) ?? 0;

  @override
  void dispose() {
    for (final t in [_title, _kcal, _p, _f, _c]) {
      t.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget numField(TextEditingController t, String label) => Expanded(
          child: TextField(
            controller: t,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: label),
          ),
        );
    return AlertDialog(
      title: const Text('Своя запись'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _title, decoration: const InputDecoration(labelText: 'Что съели')),
            Row(children: [numField(_kcal, 'Ккал'), const SizedBox(width: 8), numField(_p, 'Белки')]),
            Row(children: [numField(_f, 'Жиры'), const SizedBox(width: 8), numField(_c, 'Углеводы')]),
            const SizedBox(height: 12),
            DropdownButtonFormField<MealType>(
              initialValue: _meal,
              items: [
                for (final m in MealType.values) DropdownMenuItem(value: m, child: Text(m.label)),
              ],
              onChanged: (m) => setState(() => _meal = m ?? _meal),
              decoration: const InputDecoration(labelText: 'Приём пищи'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
        FilledButton(
          onPressed: () {
            final title = _title.text.trim();
            if (title.isEmpty || _num(_kcal) <= 0) return;
            Navigator.pop(context, (
              title,
              Macros(kcal: _num(_kcal), protein: _num(_p), fat: _num(_f), carbs: _num(_c)),
              _meal,
            ));
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
