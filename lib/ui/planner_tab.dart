import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/nutrition_repository.dart' show dayKeyOf;
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/planner/planner_controller.dart';
import 'package:food_ration/planner/planner_repository.dart';
import 'package:food_ration/ui/charts.dart';
import 'package:food_ration/ui/plan_add_sheet.dart';
import 'package:food_ration/ui/recipe_detail_page.dart';
import 'package:food_ration/ui/recipe_image.dart';

/// Меню на неделю, запасы продуктов и список покупок.
class PlannerTab extends StatefulWidget {
  const PlannerTab({super.key, required this.controller, required this.planner});

  final NutritionController controller;
  final PlannerController planner;

  @override
  State<PlannerTab> createState() => PlannerTabState();
}

class PlannerTabState extends State<PlannerTab> with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 3, vsync: this);

  /// Системная «Назад»: с «Продуктов» и «Покупок» — на «Меню».
  bool handleBack() {
    if (_tabs.index == 0) return false;
    _tabs.animateTo(0);
    return true;
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planner = widget.planner;
    return Column(
      children: [
        ListenableBuilder(
          listenable: planner,
          builder: (context, _) {
            final toBuy = planner.projection.shopping.length;
            return TabBar(
              controller: _tabs,
              tabs: [
                const Tab(text: 'Меню'),
                Tab(text: 'Продукты (${planner.pantry.length})'),
                Tab(text: toBuy == 0 ? 'Покупки' : 'Покупки ($toBuy)'),
              ],
            );
          },
        ),
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: [
              _MenuView(controller: widget.controller, planner: planner),
              _PantryView(controller: widget.controller, planner: planner),
              _ShoppingView(planner: planner),
            ],
          ),
        ),
      ],
    );
  }
}

String _qty(double amount, PantryUnit unit) => PantryItem.formatQty(amount, unit);

// ---------------------------------------------------------------- Меню

class _MenuView extends StatefulWidget {
  const _MenuView({required this.controller, required this.planner});

  final NutritionController controller;
  final PlannerController planner;

  @override
  State<_MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<_MenuView> {
  int _week = 0;

  @override
  Widget build(BuildContext context) {
    final planner = widget.planner;
    final today = planner.today;
    final start = DateTime(today.year, today.month, today.day + 7 * _week);
    final days = [for (var i = 0; i < 7; i++) DateTime(start.year, start.month, start.day + i)];
    return ListenableBuilder(
      listenable: Listenable.merge([planner, widget.controller]),
      builder: (context, _) {
        final theme = Theme.of(context);
        return ListView(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: 'Предыдущая неделя',
                  onPressed: _week <= -4 ? null : () => setState(() => _week--),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Text(
                    '${shortDayLabel(days.first, today)} — ${shortDayLabel(days.last, today)}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  tooltip: 'Следующая неделя',
                  onPressed: _week >= 8 ? null : () => setState(() => _week++),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            if (planner.plan.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: Text(
                  'Составьте меню: нажмите «+» у приёма пищи. Сначала будут блюда из '
                  'продуктов, которые у вас есть (вкладка «Продукты»). Остатки '
                  'пересчитываются по меню: если творога куплено 500 г, а на завтрак '
                  'уходит 150 г, остальные 350 г пойдут в следующие блюда.',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            for (final d in days)
              _DayCard(
                day: d,
                today: today,
                controller: widget.controller,
                planner: planner,
              ),
          ],
        );
      },
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.day,
    required this.today,
    required this.controller,
    required this.planner,
  });

  final DateTime day;
  final DateTime today;
  final NutritionController controller;
  final PlannerController planner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final key = dayKeyOf(day);
    final macros = planner.dayMacros(key);
    final target = controller.kbju?.target;
    final isToday = day == today;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: isToday
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 4, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(longDayLabel(day, today), style: theme.textTheme.titleMedium),
                ),
                if (macros.kcal > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      target == null
                          ? '${macros.kcal.round()} ккал'
                          : '${macros.kcal.round()} / ${target.kcal.round()} ккал',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: target != null && macros.kcal > target.kcal + 50
                            ? theme.colorScheme.error
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
            for (final m in MealType.values) ...[
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: MacroColors.meals[m], shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(m.label, style: theme.textTheme.labelLarge)),
                  IconButton(
                    key: Key('plan-add-$key-${m.name}'),
                    tooltip: 'Добавить блюдо',
                    visualDensity: VisualDensity.compact,
                    onPressed: () => _RecipePickerPage.open(
                      context,
                      controller: controller,
                      planner: planner,
                      day: day,
                      meal: m,
                    ),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              for (final e in planner.entriesFor(key, m))
                _PlanEntryTile(entry: e, controller: controller, planner: planner, today: today),
            ],
          ],
        ),
      ),
    );
  }
}

class _PlanEntryTile extends StatelessWidget {
  const _PlanEntryTile({
    required this.entry,
    required this.controller,
    required this.planner,
    required this.today,
  });

  final PlanEntry entry;
  final NutritionController controller;
  final PlannerController planner;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipe = planner.catalog.byKey(entry.recipeKey);
    if (recipe == null) {
      return ListTile(
        dense: true,
        title: const Text('Рецепт не найден'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => planner.removeFromPlan(entry),
        ),
      );
    }
    final proj = planner.projection.entries[entry.id];
    final String status;
    final Color statusColor;
    final dark = theme.brightness == Brightness.dark;
    if (entry.done) {
      status = 'Приготовлено';
      statusColor = theme.colorScheme.onSurfaceVariant;
    } else if (proj == null) {
      status = 'День прошёл';
      statusColor = theme.colorScheme.onSurfaceVariant;
    } else if (proj.missing.isEmpty) {
      status = proj.lines.isEmpty ? 'Без учёта продуктов' : 'Все продукты есть';
      statusColor = dark ? Colors.green.shade300 : Colors.green.shade700;
    } else {
      final names = proj.missing.map((l) => l.item?.name ?? l.ingredient.name).toSet();
      status = 'Докупить: ${names.take(3).join(', ')}${names.length > 3 ? ' и ещё ${names.length - 3}' : ''}';
      statusColor = dark ? Colors.orange.shade300 : Colors.orange.shade800;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => _PlanEntrySheet.show(context, entry, recipe, controller, planner),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 2, 8, 6),
        child: Row(
          children: [
            Opacity(
              opacity: entry.done ? 0.5 : 1,
              child: RecipeImage(recipe: recipe, width: 44, height: 44, borderRadius: 8, cacheWidth: 132),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      decoration: entry.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    '${recipe.servingsLabel(entry.servings)} · ${recipe.defaultPortionMacros.kcal.round()} ккал/порц.',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    status,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(color: statusColor),
                  ),
                ],
              ),
            ),
            if (entry.done) Icon(Icons.check, color: theme.colorScheme.primary, size: 20),
          ],
        ),
      ),
    );
  }
}

class _PlanEntrySheet extends StatelessWidget {
  const _PlanEntrySheet({
    required this.entryId,
    required this.recipe,
    required this.controller,
    required this.planner,
  });

  final int entryId;
  final Recipe recipe;
  final NutritionController controller;
  final PlannerController planner;

  static Future<void> show(
    BuildContext context,
    PlanEntry entry,
    Recipe recipe,
    NutritionController controller,
    PlannerController planner,
  ) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => _PlanEntrySheet(
          entryId: entry.id!,
          recipe: recipe,
          controller: controller,
          planner: planner,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: planner,
      builder: (context, _) {
        final entry = planner.plan.where((e) => e.id == entryId).firstOrNull;
        if (entry == null) return const SizedBox.shrink();
        final theme = Theme.of(context);
        final proj = planner.projection.entries[entry.id];
        final dark = theme.brightness == Brightness.dark;
        final scale = recipe.ingredientScale(entry.servings);
        final isToday = entry.dayKey == dayKeyOf(planner.today);
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.95,
          builder: (context, scroll) => ListView(
            controller: scroll,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            children: [
              Text(recipe.name, style: theme.textTheme.titleLarge),
              Text(
                '${entry.meal.label} · ${recipe.defaultPortionMacros.format()} на порцию',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('Готовлю:', style: theme.textTheme.bodyLarge),
                  const SizedBox(width: 8),
                  IconButton.outlined(
                    visualDensity: VisualDensity.compact,
                    onPressed: entry.done || entry.servings <= 1
                        ? null
                        : () => planner.setServings(entry, (entry.servings - 1).ceilToDouble().clamp(1, 99)),
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Text(
                      recipe.servingsLabel(entry.servings),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton.outlined(
                    key: const Key('plan-servings-plus'),
                    visualDensity: VisualDensity.compact,
                    onPressed: entry.done ? null : () => planner.setServings(entry, (entry.servings + 1).floorToDouble()),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Продукты', style: theme.textTheme.titleSmall),
              const SizedBox(height: 4),
              for (final i in recipe.parsedIngredients)
                Builder(builder: (_) {
                  final line = proj?.lines.where((l) => l.ingredient == i).firstOrNull;
                  String? hint;
                  Color? color;
                  if (line != null && !entry.done) {
                    if (line.item == null) {
                      hint = 'нет в запасах';
                      color = dark ? Colors.orange.shade300 : Colors.orange.shade800;
                    } else if (line.isShort) {
                      hint = '${line.item!.name}: не хватает ${_qty(line.shortage, line.item!.unit)}';
                      color = dark ? Colors.orange.shade300 : Colors.orange.shade800;
                    } else {
                      hint = 'из запасов: ${line.item!.name}';
                      color = dark ? Colors.green.shade300 : Colors.green.shade700;
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ${i.scaled(scale)}'),
                        if (hint != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(hint, style: theme.textTheme.bodySmall?.copyWith(color: color)),
                          ),
                      ],
                    ),
                  );
                }),
              const SizedBox(height: 16),
              if (!entry.done)
                FilledButton.icon(
                  key: const Key('plan-cooked'),
                  onPressed: () async {
                    await planner.markCooked(entry);
                    if (isToday) await controller.logRecipe(recipe, recipe.defaultPortion, entry.meal);
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isToday
                              ? 'Продукты списаны, порция записана в дневник'
                              : 'Продукты списаны из запасов',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.soup_kitchen_outlined),
                  label: Text(isToday ? 'Приготовлено и съедено' : 'Приготовлено'),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        RecipeDetailPage.open(context, controller, recipe, meal: entry.meal);
                      },
                      icon: const Icon(Icons.menu_book_outlined),
                      label: const Text('Рецепт'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const Key('plan-remove'),
                      onPressed: () {
                        planner.removeFromPlan(entry);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Убрать'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------- Подбор рецепта

/// Подбор блюда для плана: сверху то, что готовится из имеющихся продуктов.
class _RecipePickerPage extends StatefulWidget {
  const _RecipePickerPage({
    required this.controller,
    required this.planner,
    this.day,
    this.meal,
  });

  final NutritionController controller;
  final PlannerController planner;

  /// Если заданы — блюдо сразу добавляется в этот день и приём пищи.
  final DateTime? day;
  final MealType? meal;

  static Future<void> open(
    BuildContext context, {
    required NutritionController controller,
    required PlannerController planner,
    DateTime? day,
    MealType? meal,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => _RecipePickerPage(controller: controller, planner: planner, day: day, meal: meal),
        ),
      );

  @override
  State<_RecipePickerPage> createState() => _RecipePickerPageState();
}

class _RecipePickerPageState extends State<_RecipePickerPage> {
  final _search = TextEditingController();
  late MealType? _meal = widget.meal;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _pick(Recipe r) async {
    final planner = widget.planner;
    if (widget.day != null) {
      await planner.addToPlan(r, widget.day!, widget.meal!);
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('«${r.name}» → ${widget.meal!.label.toLowerCase()}, ${shortDayLabel(widget.day!, planner.today).toLowerCase()}')),
      );
      return;
    }
    final added = await showAddToPlanSheet(context, planner: planner, recipe: r, servings: 1, meal: _meal);
    if (added && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('«${r.name}» добавлено в план')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final planner = widget.planner;
    final title = widget.day == null
        ? 'Что приготовить'
        : '${widget.meal!.label} · ${shortDayLabel(widget.day!, planner.today)}';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListenableBuilder(
        listenable: planner,
        builder: (context, _) {
          final list = planner.suggestFromPantry(_meal, query: _search.text);
          final hasPantry = planner.pantry.isNotEmpty;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                child: TextField(
                  key: const Key('picker-search'),
                  controller: _search,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Название или продукт',
                    border: const OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: _search.text.isEmpty
                        ? null
                        : IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(_search.clear)),
                  ),
                ),
              ),
              if (widget.day == null)
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    children: [
                      for (final m in MealType.values)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(m.label),
                            selected: _meal == m,
                            onSelected: (v) => setState(() => _meal = v ? m : null),
                          ),
                        ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    hasPantry
                        ? 'Сверху — блюда, для которых больше всего продуктов уже есть (с учётом меню)'
                        : 'Добавьте покупки во вкладке «Продукты» — тогда блюда будут подбираться под них',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final s = list[i];
                    final r = s.recipe;
                    final used = [for (final e in s.used.entries) '${e.key.name} ${_qty(e.value, e.key.unit)}'];
                    return RecipeListCard(
                      key: i == 0 ? const Key('picker-first') : null,
                      recipe: r,
                      badge: used.isEmpty ? null : 'Из запасов: ${used.join(', ')}',
                      subtitle: s.missing == 0
                          ? 'Всё есть · ${r.servingsLabel(1)}'
                          : 'Докупить ${s.missing} · ${r.servingsLabel(1)}',
                      macros: r.defaultPortionMacros,
                      onTap: () => _pick(r),
                      trailing: IconButton(
                        tooltip: 'Открыть рецепт',
                        icon: const Icon(Icons.info_outline),
                        onPressed: () => RecipeDetailPage.open(context, widget.controller, r, meal: _meal),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------- Продукты

class _PantryView extends StatelessWidget {
  const _PantryView({required this.controller, required this.planner});

  final NutritionController controller;
  final PlannerController planner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('pantry-add'),
        heroTag: 'pantry-add',
        onPressed: () => _PantryItemDialog.show(context, planner),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Покупка'),
      ),
      body: ListenableBuilder(
        listenable: planner,
        builder: (context, _) {
          final theme = Theme.of(context);
          final proj = planner.projection;
          final items = planner.pantry;
          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
            children: [
              if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Здесь хранятся купленные продукты. Добавьте покупки — и меню '
                    'покажет, на сколько их хватит, а подбор рецептов предложит, '
                    'что приготовить из остатков.',
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              else ...[
                FilledButton.tonalIcon(
                  onPressed: () => _RecipePickerPage.open(context, controller: controller, planner: planner),
                  icon: const Icon(Icons.auto_awesome_outlined),
                  label: const Text('Что приготовить из остатков'),
                ),
                const SizedBox(height: 8),
              ],
              for (final p in items)
                Dismissible(
                  key: ValueKey('pantry-${p.id}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    color: theme.colorScheme.errorContainer,
                    child: Icon(Icons.delete_outline, color: theme.colorScheme.onErrorContainer),
                  ),
                  onDismissed: (_) => planner.deletePantryItem(p),
                  child: _PantryTile(item: p, planned: proj.planned[p.id] ?? 0, planner: planner),
                ),
              if (items.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Смахните влево, чтобы удалить. Нажмите, чтобы изменить остаток.',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PantryTile extends StatelessWidget {
  const _PantryTile({required this.item, required this.planned, required this.planner});

  final PantryItem item;
  final double planned;
  final PlannerController planner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final left = item.amount - planned;
    final frac = item.amount <= 0 ? 0.0 : (planned / item.amount).clamp(0.0, 1.0);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _PantryItemDialog.show(context, planner, item: item),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(item.name, style: theme.textTheme.titleSmall)),
                  Text(_qty(item.amount, item.unit), style: theme.textTheme.titleSmall),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(value: frac, minHeight: 6),
              ),
              const SizedBox(height: 4),
              Text(
                planned <= 0
                    ? 'Пока не используется в меню'
                    : 'В меню: ${_qty(planned, item.unit)} · останется ${_qty(left, item.unit)}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PantryItemDialog extends StatefulWidget {
  const _PantryItemDialog({required this.planner, this.item});

  final PlannerController planner;
  final PantryItem? item;

  static Future<void> show(BuildContext context, PlannerController planner, {PantryItem? item}) =>
      showDialog<void>(
        context: context,
        builder: (_) => _PantryItemDialog(planner: planner, item: item),
      );

  @override
  State<_PantryItemDialog> createState() => _PantryItemDialogState();
}

enum _InputUnit {
  g('г', PantryUnit.g, 1),
  kg('кг', PantryUnit.g, 1000),
  ml('мл', PantryUnit.ml, 1),
  l('л', PantryUnit.ml, 1000),
  pcs('шт', PantryUnit.pcs, 1);

  const _InputUnit(this.label, this.unit, this.factor);

  final String label;
  final PantryUnit unit;
  final double factor;
}

class _PantryItemDialogState extends State<_PantryItemDialog> {
  late final _name = TextEditingController(text: widget.item?.name ?? '');
  late final _amount = TextEditingController(text: _initialAmountText());
  late _InputUnit _unit = switch (widget.item?.unit) {
    PantryUnit.ml => _InputUnit.ml,
    PantryUnit.pcs => _InputUnit.pcs,
    _ => _InputUnit.g,
  };

  String _initialAmountText() {
    final a = widget.item?.amount;
    if (a == null) return '';
    return a == a.roundToDouble() ? a.round().toString() : a.toStringAsFixed(1).replaceAll('.', ',');
  }

  double? get _value => double.tryParse(_amount.text.replaceAll(',', '.').trim());

  bool get _valid => _name.text.trim().isNotEmpty && (_value ?? 0) > 0;

  @override
  void dispose() {
    _name.dispose();
    _amount.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = _value! * _unit.factor;
    final name = _name.text.trim();
    final item = widget.item;
    if (item == null) {
      await widget.planner.addToPantry(name, amount, _unit.unit);
    } else {
      await widget.planner.updatePantryItem(item.copyWith(name: name, amount: amount, unit: _unit.unit));
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Покупка' : 'Остаток продукта'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('pantry-name'),
            controller: _name,
            autofocus: widget.item == null,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(labelText: 'Продукт', hintText: 'Творог'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          TextField(
            key: const Key('pantry-amount'),
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
            decoration: const InputDecoration(labelText: 'Количество', hintText: '500'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            children: [
              for (final u in _InputUnit.values)
                ChoiceChip(
                  label: Text(u.label),
                  selected: _unit == u,
                  onSelected: (_) => setState(() => _unit = u),
                ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Отмена')),
        FilledButton(
          key: const Key('pantry-save'),
          onPressed: _valid ? _save : null,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------- Покупки

class _ShoppingView extends StatelessWidget {
  const _ShoppingView({required this.planner});

  final PlannerController planner;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: planner,
      builder: (context, _) {
        final theme = Theme.of(context);
        final proj = planner.projection;
        final list = proj.shopping;
        return ListView(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
          children: [
            if (proj.entries.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Список покупок составляется по меню. Добавьте блюда в план — здесь '
                  'появится всё, чего не хватает в запасах.',
                  style: theme.textTheme.bodyMedium,
                ),
              )
            else if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Всех продуктов с количеством хватает на всё меню.',
                  style: theme.textTheme.bodyMedium,
                ),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                child: Text(
                  'Не хватает на меню с сегодняшнего дня. Отметьте купленное — '
                  'продукт попадёт в запасы, а количество можно поправить там.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  key: const Key('buy-all'),
                  onPressed: () async {
                    for (final s in List.of(list)) {
                      await planner.buy(s);
                    }
                  },
                  icon: const Icon(Icons.done_all),
                  label: const Text('Купила всё'),
                ),
              ),
              for (final s in list)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    leading: IconButton(
                      tooltip: 'Куплено',
                      icon: const Icon(Icons.check_box_outline_blank),
                      onPressed: () => planner.buy(s),
                    ),
                    title: Text(_capitalize(s.name)),
                    subtitle: Text(
                      s.recipes.join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      _qty(PlannerController.roundUp(s.amount, s.unit), s.unit),
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
            ],
            if (proj.unmeasured.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Ещё в рецептах (без количества)', style: theme.textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(proj.unmeasured.join(', '), style: theme.textTheme.bodySmall),
            ],
          ],
        );
      },
    );
  }

  static String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
