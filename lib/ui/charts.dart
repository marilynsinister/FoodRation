import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/kbju_calculator.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/recipe.dart';

abstract final class MacroColors {
  static const kcal = Color(0xFFF57C00);
  static const protein = Color(0xFFE53935);
  static const fat = Color(0xFFFFB300);
  static const carbs = Color(0xFF1E88E5);

  static const meals = {
    MealType.breakfast: Color(0xFFFFA726),
    MealType.lunch: Color(0xFF66BB6A),
    MealType.snack: Color(0xFFAB47BC),
    MealType.dinner: Color(0xFF5C6BC0),
  };
}

/// Доли калорий из белков, жиров и углеводов (сумма = 1).
({double protein, double fat, double carbs}) energyShares(Macros m) {
  final p = m.protein * kcalPerGramProtein;
  final f = m.fat * kcalPerGramFat;
  final c = m.carbs * kcalPerGramCarb;
  final total = p + f + c;
  if (total <= 0) return (protein: 0, fat: 0, carbs: 0);
  return (protein: p / total, fat: f / total, carbs: c / total);
}

/// Кольцо прогресса с подписью в центре.
class RingProgress extends StatelessWidget {
  const RingProgress({
    super.key,
    required this.value,
    required this.color,
    required this.size,
    this.stroke = 12,
    this.center,
  });

  /// 0..1+, больше 1 — перебор (рисуется цветом ошибки).
  final double value;
  final Color color;
  final double size;
  final double stroke;
  final Widget? center;

  @override
  Widget build(BuildContext context) {
    final over = value > 1.05;
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _RingPainter(
          value: value.clamp(0.0, 1.0),
          color: over ? Theme.of(context).colorScheme.error : color,
          stroke: stroke,
        ),
        child: Center(child: center),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.value, required this.color, required this.stroke});

  final double value;
  final Color color;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = color.withValues(alpha: 0.15);
    canvas.drawArc(rect, 0, math.pi * 2, false, bg);
    if (value <= 0) return;
    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * value, false, fg);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value || old.color != color || old.stroke != stroke;
}

/// Кольцевая диаграмма «откуда калории»: белки / жиры / углеводы.
class MacroDonut extends StatelessWidget {
  const MacroDonut({super.key, required this.macros, this.size = 120, this.center});

  final Macros macros;
  final double size;
  final Widget? center;

  @override
  Widget build(BuildContext context) {
    final s = energyShares(macros);
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _DonutPainter([
          (s.protein, MacroColors.protein),
          (s.fat, MacroColors.fat),
          (s.carbs, MacroColors.carbs),
        ], stroke: size * 0.16),
        child: Center(child: center),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter(this.segments, {required this.stroke});

  final List<(double, Color)> segments;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(stroke / 2);
    var start = -math.pi / 2;
    const gap = 0.03;
    for (final (share, color) in segments) {
      if (share <= 0) continue;
      final sweep = math.pi * 2 * share;
      canvas.drawArc(
        rect,
        start + gap / 2,
        math.max(0, sweep - gap),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..color = color,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) => true;
}

/// Легенда к [MacroDonut]: граммы и доля калорий.
class MacroLegend extends StatelessWidget {
  const MacroLegend({super.key, required this.macros});

  final Macros macros;

  @override
  Widget build(BuildContext context) {
    final s = energyShares(macros);
    final style = Theme.of(context).textTheme.bodyMedium;
    Widget row(Color c, String label, double grams, double share) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$label ${grams.round()} г',
                  style: style,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${(share * 100).round()}%',
                style: style?.copyWith(color: Theme.of(context).hintColor),
              ),
            ],
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        row(MacroColors.protein, 'Белки', macros.protein, s.protein),
        row(MacroColors.fat, 'Жиры', macros.fat, s.fat),
        row(MacroColors.carbs, 'Углеводы', macros.carbs, s.carbs),
      ],
    );
  }
}

/// Тонкая полоска соотношения БЖУ по калориям — для списков.
class MacroSplitBar extends StatelessWidget {
  const MacroSplitBar({super.key, required this.macros, this.height = 5});

  final Macros macros;
  final double height;

  @override
  Widget build(BuildContext context) {
    final s = energyShares(macros);
    int flex(double v) => math.max(1, (v * 1000).round());
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(flex: flex(s.protein), child: const ColoredBox(color: MacroColors.protein)),
            Expanded(flex: flex(s.fat), child: const ColoredBox(color: MacroColors.fat)),
            Expanded(flex: flex(s.carbs), child: const ColoredBox(color: MacroColors.carbs)),
          ],
        ),
      ),
    );
  }
}

/// Калории по приёмам пищи: съедено (насыщенный цвет) и план (бледный)
/// относительно дневной нормы.
class MealDistributionBar extends StatelessWidget {
  const MealDistributionBar({
    super.key,
    required this.target,
    required this.eaten,
    this.planned = const {},
  });

  final double target;
  final Map<MealType, double> eaten;
  final Map<MealType, double> planned;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parts = <(double, Color)>[];
    for (final m in MealType.values) {
      final e = eaten[m] ?? 0;
      final p = planned[m] ?? 0;
      if (e > 0) parts.add((e, MacroColors.meals[m]!));
      if (p > 0) parts.add((p, MacroColors.meals[m]!.withValues(alpha: 0.35)));
    }
    final used = parts.fold<double>(0, (s, p) => s + p.$1);
    final scale = math.max(target, used);
    final free = scale - used;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 14,
            child: Row(
              children: [
                for (final (v, c) in parts)
                  Expanded(flex: math.max(1, (v / scale * 1000).round()), child: ColoredBox(color: c)),
                if (free > 1)
                  Expanded(
                    flex: math.max(1, (free / scale * 1000).round()),
                    child: ColoredBox(color: theme.colorScheme.surfaceContainerHighest),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            for (final m in MealType.values)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: MacroColors.meals[m],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${m.label} ${((eaten[m] ?? 0) + (planned[m] ?? 0)).round()}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
