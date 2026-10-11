import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/macros.dart';

/// Полоски «съедено / норма» по калориям и БЖУ.
class MacroProgress extends StatelessWidget {
  const MacroProgress({super.key, required this.eaten, required this.target});

  final Macros eaten;
  final Macros target;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bar(context, 'Калории', eaten.kcal, target.kcal, 'ккал', Colors.orange),
        _bar(context, 'Белки', eaten.protein, target.protein, 'г', Colors.red),
        _bar(context, 'Жиры', eaten.fat, target.fat, 'г', Colors.amber.shade700),
        _bar(context, 'Углеводы', eaten.carbs, target.carbs, 'г', Colors.blue),
      ],
    );
  }

  Widget _bar(BuildContext context, String label, double v, double max, String unit, Color color) {
    final over = v > max * 1.05;
    final ratio = max <= 0 ? 0.0 : (v / max).clamp(0.0, 1.0);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: theme.textTheme.bodyMedium),
              const Spacer(),
              Text(
                '${v.round()} / ${max.round()} $unit',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: over ? theme.colorScheme.error : null,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              color: over ? theme.colorScheme.error : color,
              backgroundColor: color.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }
}

/// Компактная строка «320 ккал  Б 25  Ж 10  У 30».
class MacroLine extends StatelessWidget {
  const MacroLine(this.macros, {super.key, this.style});

  final Macros macros;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final s = style ?? Theme.of(context).textTheme.bodySmall;
    return Text.rich(
      TextSpan(
        style: s,
        children: [
          TextSpan(
            text: '${macros.kcal.round()} ккал',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: '   Б ${macros.protein.round()}  Ж ${macros.fat.round()}  '
                'У ${macros.carbs.round()}',
          ),
        ],
      ),
    );
  }
}
