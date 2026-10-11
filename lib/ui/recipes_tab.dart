import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/nutrition/recommender.dart';
import 'package:food_ration/ui/recipe_detail_page.dart';
import 'package:food_ration/ui/recipe_image.dart';

/// Каталог рецептов из всех сборников с фильтрами и режимом «впишется в остаток».
class RecipesTab extends StatefulWidget {
  const RecipesTab({super.key, required this.controller});

  final NutritionController controller;

  @override
  State<RecipesTab> createState() => _RecipesTabState();
}

class _RecipesTabState extends State<RecipesTab> {
  final _search = TextEditingController();
  MealType? _meal;
  String? _category;
  String? _book;
  bool _fitOnly = true;

  NutritionController get c => widget.controller;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _matches(Recipe r) {
    final q = _search.text.trim().toLowerCase();
    if (q.isNotEmpty && !q.split(RegExp(r'\s+')).every(r.searchText.contains)) return false;
    if (_meal != null && !r.mealTypes.contains(_meal)) return false;
    if (_category != null && r.category != _category) return false;
    if (_book != null && r.book != _book) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: c,
      builder: (context, _) {
        final day = c.day;
        final fitMode = _fitOnly && day != null;
        final items = <(Recipe, Suggestion?)>[];
        if (fitMode) {
          final meal = _meal ?? day.nextMeal;
          final budget = day.budgetFor(meal);
          for (final r in c.catalog.recipes) {
            if (!_matches(r)) continue;
            if (_meal == null && r.mealTypes.isEmpty) continue;
            final s = Recommender.fit(r, budget: budget, remaining: day.remaining);
            if (s != null) items.add((r, s));
          }
          items.sort((a, b) => a.$2!.score.compareTo(b.$2!.score));
        } else {
          for (final r in c.catalog.recipes) {
            if (_matches(r)) items.add((r, null));
          }
          items.sort((a, b) => a.$1.name.compareTo(b.$1.name));
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: TextField(
                key: const Key('recipe-search'),
                controller: _search,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Название или продукт: творог, курица…',
                  border: const OutlineInputBorder(),
                  isDense: true,
                  suffixIcon: _search.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(_search.clear),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                children: [
                  if (day != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        key: const Key('fit-only'),
                        label: const Text('Впишется в остаток'),
                        selected: _fitOnly,
                        onSelected: (v) => setState(() => _fitOnly = v),
                      ),
                    ),
                  for (final m in MealType.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(m.label),
                        selected: _meal == m,
                        onSelected: (v) => setState(() => _meal = v ? m : null),
                      ),
                    ),
                  _MenuChip(
                    label: _category ?? 'Категория',
                    active: _category != null,
                    options: c.catalog.categories,
                    onSelected: (v) => setState(() => _category = v),
                  ),
                  _MenuChip(
                    label: _book ?? 'Сборник',
                    active: _book != null,
                    options: c.catalog.books,
                    onSelected: (v) => setState(() => _book = v),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  fitMode
                      ? 'Помещаются в остаток (${day.remaining.kcal.round()} ккал): '
                          '${items.length}, лучшие сверху'
                      : 'Рецептов: ${items.length}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final (r, s) = items[i];
                  final portion = s?.portion ?? r.defaultPortion;
                  final macros = s?.macros ?? r.macrosFor(portion);
                  return RecipeListCard(
                    recipe: r,
                    subtitle: '${r.portionLabel(portion)} · ${r.category} · ${r.book}',
                    macros: macros,
                    onTap: () => RecipeDetailPage.open(
                      context,
                      c,
                      r,
                      portion: portion,
                      meal: _meal ?? (fitMode ? day.nextMeal : null),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MenuChip extends StatelessWidget {
  const _MenuChip({
    required this.label,
    required this.active,
    required this.options,
    required this.onSelected,
  });

  final String label;
  final bool active;
  final List<String> options;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<String>(
        onSelected: (v) => onSelected(v.isEmpty ? null : v),
        itemBuilder: (_) => [
          const PopupMenuItem(value: '', child: Text('Все')),
          for (final o in options) PopupMenuItem(value: o, child: Text(o)),
        ],
        child: Chip(
          label: Text(label),
          avatar: const Icon(Icons.arrow_drop_down, size: 18),
          backgroundColor: active ? Theme.of(context).colorScheme.secondaryContainer : null,
        ),
      ),
    );
  }
}
