import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/planner/planner_controller.dart';

const _weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
const _weekdaysFull = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];

String _dm(DateTime d) => '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}';

/// «Сегодня», «Завтра», «Пт 17.10».
String shortDayLabel(DateTime d, DateTime today) {
  final diff = d.difference(today).inDays;
  if (diff == 0) return 'Сегодня';
  if (diff == 1) return 'Завтра';
  return '${_weekdays[d.weekday - 1]} ${_dm(d)}';
}

/// «Пятница, 17.10 · завтра».
String longDayLabel(DateTime d, DateTime today) {
  final diff = d.difference(today).inDays;
  final rel = switch (diff) { 0 => ' · сегодня', 1 => ' · завтра', -1 => ' · вчера', _ => '' };
  return '${_weekdaysFull[d.weekday - 1]}, ${_dm(d)}$rel';
}

/// Выбор дня и приёма пищи для блюда; возвращает true, если добавлено.
Future<bool> showAddToPlanSheet(
  BuildContext context, {
  required PlannerController planner,
  required Recipe recipe,
  required double servings,
  MealType? meal,
}) async {
  final added = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _AddToPlanSheet(
      planner: planner,
      recipe: recipe,
      servings: servings,
      initialMeal: meal ?? (recipe.mealTypes.isNotEmpty ? recipe.mealTypes.first : MealType.lunch),
    ),
  );
  return added ?? false;
}

class _AddToPlanSheet extends StatefulWidget {
  const _AddToPlanSheet({
    required this.planner,
    required this.recipe,
    required this.servings,
    required this.initialMeal,
  });

  final PlannerController planner;
  final Recipe recipe;
  final double servings;
  final MealType initialMeal;

  @override
  State<_AddToPlanSheet> createState() => _AddToPlanSheetState();
}

class _AddToPlanSheetState extends State<_AddToPlanSheet> {
  late final DateTime _today = widget.planner.today;
  late DateTime _day = _today;
  late MealType _meal = widget.initialMeal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Добавить в план', style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              '${widget.recipe.name} · ${widget.recipe.servingsLabel(widget.servings)}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text('День', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < 14; i++)
                  Builder(builder: (_) {
                    final d = DateTime(_today.year, _today.month, _today.day + i);
                    return ChoiceChip(
                      label: Text(shortDayLabel(d, _today)),
                      selected: d == _day,
                      onSelected: (_) => setState(() => _day = d),
                    );
                  }),
              ],
            ),
            const SizedBox(height: 16),
            Text('Приём пищи', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<MealType>(
              segments: [
                for (final m in MealType.values)
                  ButtonSegment(value: m, label: Text(m.label, overflow: TextOverflow.ellipsis)),
              ],
              selected: {_meal},
              showSelectedIcon: false,
              onSelectionChanged: (s) => setState(() => _meal = s.first),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              key: const Key('confirm-add-to-plan'),
              onPressed: () async {
                await widget.planner.addToPlan(widget.recipe, _day, _meal, servings: widget.servings);
                if (context.mounted) Navigator.of(context).pop(true);
              },
              icon: const Icon(Icons.event_available),
              label: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
