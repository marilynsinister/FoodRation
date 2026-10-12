import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:food_ration/nutrition/kbju_calculator.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/ui/charts.dart';

/// Калькулятор КБЖУ: Миффлин — Сан Жеор × активность, поправка под цель.
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key, required this.controller, required this.onSaved});

  final NutritionController controller;
  final VoidCallback onSaved;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late NutritionProfile _p = widget.controller.profile ?? NutritionProfile.initial;
  late final _age = TextEditingController(text: '${_p.age}');
  late final _height = TextEditingController(text: _fmt(_p.heightCm));
  late final _weight = TextEditingController(text: _fmt(_p.weightKg));
  late final _custom = TextEditingController(text: _p.customKcal == null ? '' : _fmt(_p.customKcal!));
  late bool _useCustom = _p.customKcal != null;

  static String _fmt(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  static double? _parse(String s) => double.tryParse(s.replaceAll(',', '.').trim());

  @override
  void dispose() {
    for (final t in [_age, _height, _weight, _custom]) {
      t.dispose();
    }
    super.dispose();
  }

  void _updateNumbers() {
    setState(() {
      _p = _p.copyWith(
        age: _parse(_age.text)?.round(),
        heightCm: _parse(_height.text),
        weightKg: _parse(_weight.text),
        customKcal: () => _useCustom ? _parse(_custom.text) : null,
      );
    });
  }

  bool get _valid =>
      _p.age >= 14 && _p.age <= 100 &&
      _p.heightCm >= 120 && _p.heightCm <= 230 &&
      _p.weightKg >= 35 && _p.weightKg <= 250;

  Future<void> _save() async {
    await widget.controller.saveProfile(_p);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Норма сохранена')),
    );
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = _valid ? calculateKbju(_p) : null;
    Widget numField(TextEditingController t, String label, String suffix, Key key) => Expanded(
          child: TextField(
            key: key,
            controller: t,
            onChanged: (_) => _updateNumbers(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
            decoration: InputDecoration(
              labelText: label,
              suffixText: suffix,
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
        );
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        Text('Калькулятор КБЖУ', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),
        SegmentedButton<Sex>(
          segments: [for (final s in Sex.values) ButtonSegment(value: s, label: Text(s.label))],
          selected: {_p.sex},
          onSelectionChanged: (s) => setState(() => _p = _p.copyWith(sex: s.first)),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            numField(_age, 'Возраст', 'лет', const Key('age')),
            const SizedBox(width: 8),
            numField(_height, 'Рост', 'см', const Key('height')),
            const SizedBox(width: 8),
            numField(_weight, 'Вес', 'кг', const Key('weight')),
          ],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<ActivityLevel>(
          initialValue: _p.activity,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Активность',
            border: OutlineInputBorder(),
          ),
          items: [
            for (final a in ActivityLevel.values)
              DropdownMenuItem(
                value: a,
                child: Text('${a.label} — ${a.description}', overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (a) => setState(() => _p = _p.copyWith(activity: a)),
        ),
        const SizedBox(height: 16),
        Text('Цель', style: theme.textTheme.titleMedium),
        RadioGroup<Goal>(
          groupValue: _p.goal,
          onChanged: (g) => setState(() => _p = _p.copyWith(goal: g)),
          child: Column(
            children: [
              for (final g in Goal.values)
                RadioListTile<Goal>(
                  key: Key('goal-${g.name}'),
                  value: g,
                  contentPadding: EdgeInsets.zero,
                  title: Text(g.label),
                  subtitle: Text(
                    '${g.description}; белок ${g.proteinPerKg} г/кг, жиры ${g.fatPerKg} г/кг',
                  ),
                ),
            ],
          ),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Задать калории вручную'),
          subtitle: const Text('Например, норма из рациона нутрициолога'),
          value: _useCustom,
          onChanged: (v) {
            _useCustom = v;
            _updateNumbers();
          },
        ),
        if (_useCustom)
          Row(children: [numField(_custom, 'Калории в день', 'ккал', const Key('custom-kcal'))]),
        const SizedBox(height: 16),
        if (result == null)
          Text(
            'Проверьте данные: возраст 14–100, рост 120–230 см, вес 35–250 кг.',
            style: TextStyle(color: theme.colorScheme.error),
          )
        else
          _ResultCard(result: result),
        const SizedBox(height: 16),
        FilledButton.icon(
          key: const Key('save-profile'),
          onPressed: result == null ? null : _save,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Сохранить и подобрать рецепты'),
        ),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final KbjuResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = result.target;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ваша норма на день', style: theme.textTheme.labelLarge),
            Text(
              '${t.kcal.round()} ккал',
              key: const Key('target-kcal'),
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                MacroDonut(
                  macros: t,
                  size: 112,
                  center: Text(
                    '${t.kcal.round()}\nккал',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: MacroLegend(macros: t)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Базовый обмен: ${result.bmr.round()} ккал · '
              'расход с активностью: ${result.tdee.round()} ккал',
              style: theme.textTheme.bodySmall,
            ),
            if (result.limitedByBmr)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Дефицит ограничен базовым обменом: есть меньше него не рекомендуется.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.brightness == Brightness.dark ? Colors.orange.shade300 : Colors.orange.shade800,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
