import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:food_ration/foods/custom_foods.dart';
import 'package:food_ration/foods/food_reference.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/ui/charts.dart';
import 'package:food_ration/ui/custom_food_page.dart';
import 'package:food_ration/ui/macro_widgets.dart';

/// Своё блюдо: ингредиенты с весом → КБЖУ; съеденное записывается в дневник,
/// блюдо можно сохранить в «Мои блюда».
class DishComposerPage extends StatefulWidget {
  const DishComposerPage({super.key, required this.controller, required this.foods, this.dish});

  final NutritionController controller;
  final CustomFoodsController foods;

  /// Редактирование сохранённого блюда.
  final CustomFood? dish;

  static Future<void> open(
    BuildContext context,
    NutritionController controller,
    CustomFoodsController foods, {
    CustomFood? dish,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DishComposerPage(controller: controller, foods: foods, dish: dish),
        ),
      );

  @override
  State<DishComposerPage> createState() => _DishComposerPageState();
}

class _DishComposerPageState extends State<DishComposerPage> {
  late final _name = TextEditingController(text: widget.dish?.name ?? '');
  late final _cooked = TextEditingController(
    text: widget.dish?.totalWeightG == null ? '' : fmtNum(widget.dish!.totalWeightG!),
  );
  final _eaten = TextEditingController();
  late final List<FoodPart> _parts = [...?widget.dish?.parts];
  late MealType _meal = widget.controller.defaultMealNow();
  late bool _saveDish = widget.dish != null;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _cooked.dispose();
    _eaten.dispose();
    super.dispose();
  }

  double get _rawWeight => _parts.fold(0.0, (s, p) => s + p.grams);

  Macros get _total => _parts.fold(Macros.zero, (Macros s, p) => s + p.macros);

  /// Вес готового блюда: введённый или сумма ингредиентов.
  double get _dishWeight {
    final c = parseNum(_cooked.text);
    return c != null && c > 0 ? c : _rawWeight;
  }

  double get _eatenWeight {
    final e = parseNum(_eaten.text);
    return e != null && e > 0 ? e : _dishWeight;
  }

  Macros get _eatenMacros => _dishWeight <= 0 ? Macros.zero : _total * (_eatenWeight / _dishWeight);

  String get _title => _name.text.trim().isEmpty ? 'Своё блюдо' : _name.text.trim();

  Future<void> _addPart([int? index]) async {
    final part = await showModalBottomSheet<FoodPart>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _FoodPickerSheet(
        foods: widget.foods.allFoodRefs,
        initial: index == null ? null : _parts[index],
      ),
    );
    if (part == null) return;
    setState(() {
      if (index == null) {
        _parts.add(part);
      } else {
        _parts[index] = part;
      }
    });
  }

  Future<void> _logEaten() async {
    setState(() => _busy = true);
    if (_saveDish) await _saveToMyDishes();
    await widget.controller.logCustom(
      _title,
      _eatenMacros,
      _meal,
      portionLabel: '${_eatenWeight.round()} г',
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('«$_title» (${_eatenWeight.round()} г) — в ${_meal.label.toLowerCase()}')),
    );
    Navigator.of(context).pop();
  }

  Future<void> _saveToMyDishes() async {
    final cooked = parseNum(_cooked.text);
    final eaten = parseNum(_eaten.text);
    await widget.foods.save(CustomFood(
      id: widget.dish?.id,
      kind: CustomFoodKind.dish,
      name: _title,
      per100: CustomFood.per100Of(_parts, _dishWeight),
      totalWeightG: cooked != null && cooked > 0 ? cooked : null,
      // Порция по умолчанию — сколько съели сейчас, иначе всё блюдо.
      portionG: eaten != null && eaten > 0 ? eaten : (widget.dish?.portionG ?? _dishWeight),
      parts: List.of(_parts),
      mealTypes: widget.dish?.mealTypes ?? const [],
      photo: widget.dish?.photo,
    ));
  }

  Future<void> _saveOnly() async {
    setState(() => _busy = true);
    await _saveToMyDishes();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('«$_title» сохранено в «Мои блюда»')),
    );
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    await widget.foods.delete(widget.dish!);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = _total;
    final eaten = _eatenMacros;
    final hasParts = _parts.isNotEmpty;
    Widget grams(TextEditingController t, String label, String hint, Key key) => TextField(
          key: key,
          controller: t,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
          decoration: InputDecoration(labelText: label, hintText: hint, suffixText: 'г', isDense: true),
          onChanged: (_) => setState(() {}),
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dish == null ? 'Своё блюдо' : 'Моё блюдо'),
        actions: [
          if (widget.dish != null)
            IconButton(tooltip: 'Удалить', icon: const Icon(Icons.delete_outline), onPressed: _delete),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          TextField(
            key: const Key('dish-name'),
            controller: _name,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(labelText: 'Название', hintText: 'Омлет с овощами'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Text('Ингредиенты', style: theme.textTheme.titleMedium)),
              if (hasParts) Text('${_rawWeight.round()} г', style: theme.textTheme.labelLarge),
            ],
          ),
          const SizedBox(height: 4),
          if (!hasParts)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Добавьте продукты и их вес — КБЖУ посчитается автоматически. '
                'Справочник содержит базовые продукты и ваши собственные.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          for (var i = 0; i < _parts.length; i++)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 3),
              child: ListTile(
                dense: true,
                onTap: () => _addPart(i),
                title: Text(_parts[i].name),
                subtitle: Text('${_parts[i].grams.round()} г · ${_parts[i].macros.format()}'),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _parts.removeAt(i)),
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              key: const Key('dish-add-part'),
              onPressed: _addPart,
              icon: const Icon(Icons.add),
              label: const Text('Добавить ингредиент'),
            ),
          ),
          if (hasParts) ...[
            const SizedBox(height: 8),
            Text('Всё блюдо: ${total.format()}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            grams(
              _cooked,
              'Вес готового блюда',
              '${_rawWeight.round()} — если не взвешивали',
              const Key('dish-cooked'),
            ),
            const SizedBox(height: 4),
            Text(
              'При варке и жарке вес меняется. Взвесьте готовое блюдо — так съеденная '
              'часть посчитается точнее.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            grams(_eaten, 'Сколько съела', '${_dishWeight.round()} — всё блюдо', const Key('dish-eaten')),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    MacroDonut(
                      macros: eaten,
                      size: 80,
                      center: Text(
                        '${eaten.kcal.round()}\nккал',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Съедено ${_eatenWeight.round()} г', style: theme.textTheme.titleSmall),
                          MacroLegend(macros: eaten),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<MealType>(
              segments: [
                for (final m in MealType.values)
                  ButtonSegment(value: m, label: Text(m.label, overflow: TextOverflow.ellipsis)),
              ],
              selected: {_meal},
              showSelectedIcon: false,
              onSelectionChanged: (s) => setState(() => _meal = s.first),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _saveDish,
              onChanged: (v) => setState(() => _saveDish = v ?? false),
              title: const Text('Сохранить в «Мои блюда»'),
              subtitle: const Text('Чтобы потом выбирать его в рецептах и в плане'),
            ),
            FilledButton.icon(
              key: const Key('dish-log'),
              onPressed: _busy || _eatenMacros.kcal <= 0 ? null : _logEaten,
              icon: const Icon(Icons.check),
              label: const Text('Записать в дневник'),
            ),
            if (widget.dish != null || _saveDish) ...[
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _busy ? null : _saveOnly,
                child: const Text('Только сохранить блюдо'),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Выбор продукта из справочника и ввод веса.
class _FoodPickerSheet extends StatefulWidget {
  const _FoodPickerSheet({required this.foods, this.initial});

  final List<FoodRef> foods;
  final FoodPart? initial;

  @override
  State<_FoodPickerSheet> createState() => _FoodPickerSheetState();
}

class _FoodPickerSheetState extends State<_FoodPickerSheet> {
  final _query = TextEditingController();
  late final _grams = TextEditingController(text: widget.initial == null ? '' : fmtNum(widget.initial!.grams));
  late FoodRef? _selected = widget.initial == null
      ? null
      : FoodRef(
          widget.initial!.name,
          widget.initial!.per100.kcal,
          widget.initial!.per100.protein,
          widget.initial!.per100.fat,
          widget.initial!.per100.carbs,
        );

  // Свой продукт, которого нет в справочнике.
  final _kcal = TextEditingController();
  final _p = TextEditingController();
  final _f = TextEditingController();
  final _c = TextEditingController();
  bool _manual = false;

  @override
  void dispose() {
    for (final t in [_query, _grams, _kcal, _p, _f, _c]) {
      t.dispose();
    }
    super.dispose();
  }

  FoodRef? get _food {
    if (!_manual) return _selected;
    final k = parseNum(_kcal.text);
    if (_query.text.trim().isEmpty || k == null) return null;
    return FoodRef(_query.text.trim(), k, parseNum(_p.text) ?? 0, parseNum(_f.text) ?? 0, parseNum(_c.text) ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final food = _food;
    final g = parseNum(_grams.text);
    final ready = food != null && g != null && g > 0;
    final results = _selected == null && !_manual ? searchFoods(_query.text, widget.foods, limit: 30) : const <FoodRef>[];
    Widget num(TextEditingController t, String label) => Expanded(
          child: TextField(
            controller: t,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: label, isDense: true),
            onChanged: (_) => setState(() {}),
          ),
        );
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_selected == null)
                TextField(
                  key: const Key('food-search'),
                  controller: _query,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: _manual ? 'Название продукта' : 'Поиск: творог, курица, банан…',
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (_) => setState(() {}),
                )
              else
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_selected!.name, style: theme.textTheme.titleMedium),
                  subtitle: Text('На 100 г: ${_selected!.per100.format()}'),
                  trailing: TextButton(
                    onPressed: () => setState(() => _selected = null),
                    child: const Text('Другой'),
                  ),
                ),
              if (_manual) ...[
                const SizedBox(height: 8),
                Text('КБЖУ на 100 г', style: theme.textTheme.labelLarge),
                Row(children: [num(_kcal, 'Ккал'), const SizedBox(width: 8), num(_p, 'Б')]),
                Row(children: [num(_f, 'Ж'), const SizedBox(width: 8), num(_c, 'У')]),
              ],
              if (_selected != null || _manual) ...[
                const SizedBox(height: 12),
                TextField(
                  key: const Key('part-grams'),
                  controller: _grams,
                  autofocus: _selected != null,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                  decoration: const InputDecoration(labelText: 'Вес', suffixText: 'г'),
                  onChanged: (_) => setState(() {}),
                ),
                if (_selected?.pieceG != null)
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final n in [1, 2, 3])
                        ActionChip(
                          label: Text('$n шт ≈ ${(_selected!.pieceG! * n).round()} г'),
                          onPressed: () => setState(() => _grams.text = fmtNum(_selected!.pieceG! * n)),
                        ),
                    ],
                  ),
                if (ready) ...[
                  const SizedBox(height: 8),
                  MacroLine(food.forGrams(g), style: theme.textTheme.bodyLarge),
                ],
                const Spacer(),
                FilledButton(
                  key: const Key('part-done'),
                  onPressed: ready
                      ? () => Navigator.of(context).pop(FoodPart(name: food.name, grams: g, per100: food.per100))
                      : null,
                  child: const Text('Готово'),
                ),
              ] else
                Expanded(
                  child: ListView(
                    children: [
                      for (final f in results)
                        ListTile(
                          dense: true,
                          leading: f.custom ? Icon(Icons.star_outline, color: MacroColors.kcal) : null,
                          title: Text(f.name),
                          subtitle: Text('${f.kcal.round()} ккал · Б ${fmtNum(f.protein)} · '
                              'Ж ${fmtNum(f.fat)} · У ${fmtNum(f.carbs)} на 100 г'),
                          onTap: () => setState(() => _selected = f),
                        ),
                      ListTile(
                        leading: const Icon(Icons.edit_note),
                        title: const Text('Нет в списке — ввести КБЖУ вручную'),
                        onTap: () => setState(() => _manual = true),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
