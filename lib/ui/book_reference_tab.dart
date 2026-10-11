import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';

import 'package:food_ration/database/app_database.dart';

/// Справочные данные из сида книги (шаблоны рационов, сводка по БД).
class BookReferenceTab extends StatelessWidget {
  const BookReferenceTab({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_BookSnapshot>(
      future: _loadSnapshot(database),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Ошибка: ${snap.error}'));
        }
        final data = snap.data!;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Данные из сида (Ровенская, 2021)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ChipStat(label: 'Нутриенты', value: data.nutrientCount),
                _ChipStat(label: 'Продукты (примеры)', value: data.productCount),
                _ChipStat(label: 'Формулы', value: data.formulaCount),
                _ChipStat(label: 'Активность', value: data.activityCount),
                _ChipStat(label: 'Уварка', value: data.yieldCount),
                _ChipStat(label: 'Шаблоны дней', value: data.planCount),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Примеры суточных рационов',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (data.templates.isEmpty)
              const Text('Нет шаблонов — очистите данные приложения и перезапустите для повторного сида.')
            else
              ...data.templates.map(
                (t) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(t.title),
                    subtitle: Text(
                      '${t.targetCalories?.toStringAsFixed(0) ?? '—'} ккал · '
                      'Б ${t.targetProteinG?.toStringAsFixed(0) ?? '—'} · '
                      'Ж ${t.targetFatG?.toStringAsFixed(0) ?? '—'} · '
                      'У ${t.targetCarbG?.toStringAsFixed(0) ?? '—'}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (ctx) => MealPlanDetailPage(database: database, templateId: t.id, title: t.title),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  static Future<_BookSnapshot> _loadSnapshot(AppDatabase db) async {
    int nutrientCount = 0;
    {
      final q = db.selectOnly(db.nutrients)..addColumns([db.nutrients.id.count()]);
      nutrientCount = (await q.map((r) => r.read(db.nutrients.id.count())).getSingle()) ?? 0;
    }
    int productCount = 0;
    {
      final q = db.selectOnly(db.products)..addColumns([db.products.id.count()]);
      productCount = (await q.map((r) => r.read(db.products.id.count())).getSingle()) ?? 0;
    }
    int formulaCount = 0;
    {
      final q = db.selectOnly(db.formulaDefinitions)..addColumns([db.formulaDefinitions.id.count()]);
      formulaCount = (await q.map((r) => r.read(db.formulaDefinitions.id.count())).getSingle()) ?? 0;
    }
    int activityCount = 0;
    {
      final q = db.selectOnly(db.activityLevels)..addColumns([db.activityLevels.id.count()]);
      activityCount = (await q.map((r) => r.read(db.activityLevels.id.count())).getSingle()) ?? 0;
    }
    int yieldCount = 0;
    {
      final q = db.selectOnly(db.cookingYieldFactors)..addColumns([db.cookingYieldFactors.id.count()]);
      yieldCount = (await q.map((r) => r.read(db.cookingYieldFactors.id.count())).getSingle()) ?? 0;
    }
    int planCount = 0;
    {
      final q = db.selectOnly(db.mealPlanTemplates)..addColumns([db.mealPlanTemplates.id.count()]);
      planCount = (await q.map((r) => r.read(db.mealPlanTemplates.id.count())).getSingle()) ?? 0;
    }

    final templates = await (db.select(db.mealPlanTemplates)
          ..orderBy([
            (t) => OrderingTerm.asc(t.exampleNumber),
            (t) => OrderingTerm.asc(t.dayNumber),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .get();

    return _BookSnapshot(
      nutrientCount: nutrientCount,
      productCount: productCount,
      formulaCount: formulaCount,
      activityCount: activityCount,
      yieldCount: yieldCount,
      planCount: planCount,
      templates: templates
          .map(
            (e) => _TemplateRow(
              id: e.id,
              title: e.title,
              targetCalories: e.targetCalories,
              targetProteinG: e.targetProteinG,
              targetFatG: e.targetFatG,
              targetCarbG: e.targetCarbG,
            ),
          )
          .toList(),
    );
  }
}

class MealPlanDetailPage extends StatelessWidget {
  const MealPlanDetailPage({
    super.key,
    required this.database,
    required this.templateId,
    required this.title,
  });

  final AppDatabase database;
  final int templateId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<_MealBlock>>(
        future: _loadMeals(database, templateId),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Ошибка: ${snap.error}'));
          }
          final meals = snap.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: meals.length,
            itemBuilder: (context, i) {
              final m = meals[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.label,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (m.calories != null || m.proteinG != null)
                        Text(
                          '${m.calories?.toStringAsFixed(0) ?? '—'} ккал · '
                          'Б ${m.proteinG?.toStringAsFixed(1) ?? '—'} · '
                          'Ж ${m.fatG?.toStringAsFixed(1) ?? '—'} · '
                          'У ${m.carbG?.toStringAsFixed(1) ?? '—'}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      const Divider(),
                      ...m.lines.map(
                        (line) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            _formatLine(line),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: line.lineType == 'dish_title' ? FontWeight.w600 : null,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static String _formatLine(MealPlanLine line) {
    final grams = line.amountGrams != null ? ' — ${line.amountGrams} г' : '';
    final extra = line.amountText != null && line.amountText!.isNotEmpty ? ' — ${line.amountText}' : '';
    if (line.lineType == 'ingredient') {
      return '• ${line.content}$grams$extra';
    }
    if (line.lineType == 'dish_title') {
      return line.content;
    }
    return line.content;
  }

  static Future<List<_MealBlock>> _loadMeals(AppDatabase db, int templateId) async {
    final mealRows = await (db.select(db.mealPlanMeals)
          ..where((m) => m.templateId.equals(templateId))
          ..orderBy([(m) => OrderingTerm.asc(m.sortOrder)]))
        .get();

    final blocks = <_MealBlock>[];
    for (final meal in mealRows) {
      final lines = await (db.select(db.mealPlanLines)
            ..where((l) => l.mealId.equals(meal.id))
            ..orderBy([(l) => OrderingTerm.asc(l.sortOrder)]))
          .get();
      blocks.add(
        _MealBlock(
          label: meal.mealLabel,
          calories: meal.calories,
          proteinG: meal.proteinG,
          fatG: meal.fatG,
          carbG: meal.carbG,
          lines: lines,
        ),
      );
    }
    return blocks;
  }
}

class _BookSnapshot {
  _BookSnapshot({
    required this.nutrientCount,
    required this.productCount,
    required this.formulaCount,
    required this.activityCount,
    required this.yieldCount,
    required this.planCount,
    required this.templates,
  });

  final int nutrientCount;
  final int productCount;
  final int formulaCount;
  final int activityCount;
  final int yieldCount;
  final int planCount;
  final List<_TemplateRow> templates;
}

class _TemplateRow {
  _TemplateRow({
    required this.id,
    required this.title,
    required this.targetCalories,
    required this.targetProteinG,
    required this.targetFatG,
    required this.targetCarbG,
  });

  final int id;
  final String title;
  final double? targetCalories;
  final double? targetProteinG;
  final double? targetFatG;
  final double? targetCarbG;
}

class _MealBlock {
  _MealBlock({
    required this.label,
    required this.calories,
    required this.proteinG,
    required this.fatG,
    required this.carbG,
    required this.lines,
  });

  final String label;
  final double? calories;
  final double? proteinG;
  final double? fatG;
  final double? carbG;
  final List<MealPlanLine> lines;
}

class _ChipStat extends StatelessWidget {
  const _ChipStat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
      visualDensity: VisualDensity.compact,
    );
  }
}
