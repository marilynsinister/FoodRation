import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:food_ration/foods/custom_foods.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/ui/macro_widgets.dart';

double? parseNum(String s) => double.tryParse(s.replaceAll(',', '.').trim());

String fmtNum(double v) =>
    v == v.roundToDouble() ? v.round().toString() : v.toStringAsFixed(1).replaceAll('.', ',');

/// Свой продукт: полуфабрикат или готовая еда с КБЖУ с этикетки и фото.
class CustomFoodPage extends StatefulWidget {
  const CustomFoodPage({super.key, required this.foods, this.food});

  final CustomFoodsController foods;
  final CustomFood? food;

  /// Возвращает сохранённый продукт (с id) или null.
  static Future<CustomFood?> open(BuildContext context, CustomFoodsController foods, {CustomFood? food}) =>
      Navigator.of(context).push<CustomFood>(
        MaterialPageRoute(builder: (_) => CustomFoodPage(foods: foods, food: food)),
      );

  @override
  State<CustomFoodPage> createState() => _CustomFoodPageState();
}

enum _MacroBasis { per100, perPortion }

class _CustomFoodPageState extends State<CustomFoodPage> {
  late final CustomFood? _f = widget.food;
  late final _name = TextEditingController(text: _f?.name ?? '');
  late final _weight = TextEditingController(text: _f?.portionG == null ? '' : fmtNum(_f!.portionG!));
  late final _kcal = TextEditingController(text: _f == null ? '' : fmtNum(_f.per100.kcal));
  late final _p = TextEditingController(text: _f == null ? '' : fmtNum(_f.per100.protein));
  late final _fat = TextEditingController(text: _f == null ? '' : fmtNum(_f.per100.fat));
  late final _c = TextEditingController(text: _f == null ? '' : fmtNum(_f.per100.carbs));
  late Set<MealType> _meals = {...?_f?.mealTypes};
  late Uint8List? _photo = _f?.photo;
  _MacroBasis _basis = _MacroBasis.per100;
  bool _saving = false;

  @override
  void dispose() {
    for (final t in [_name, _weight, _kcal, _p, _fat, _c]) {
      t.dispose();
    }
    super.dispose();
  }

  double? get _portion => parseNum(_weight.text);

  /// КБЖУ на 100 г с учётом того, как введены значения.
  Macros? get _per100 {
    final k = parseNum(_kcal.text);
    if (k == null || k <= 0) return null;
    final m = Macros(
      kcal: k,
      protein: parseNum(_p.text) ?? 0,
      fat: parseNum(_fat.text) ?? 0,
      carbs: parseNum(_c.text) ?? 0,
    );
    if (_basis == _MacroBasis.per100) return m;
    final w = _portion;
    return w == null || w <= 0 ? null : m * (100 / w);
  }

  bool get _valid => _name.text.trim().isNotEmpty && _per100 != null;

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(source: source, maxWidth: 1024, imageQuality: 80);
      if (file == null) return;
      final bytes = await file.readAsBytes();
      setState(() => _photo = bytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Не удалось получить фото: $e')));
    }
  }

  void _switchBasis(_MacroBasis b) {
    // Пересчитываем введённые числа, чтобы не потерять значения.
    final per100 = _per100;
    final w = _portion;
    setState(() {
      _basis = b;
      if (per100 != null && w != null && w > 0) {
        final m = b == _MacroBasis.per100 ? per100 : per100 * (w / 100);
        _kcal.text = fmtNum(double.parse(m.kcal.toStringAsFixed(1)));
        _p.text = fmtNum(double.parse(m.protein.toStringAsFixed(1)));
        _fat.text = fmtNum(double.parse(m.fat.toStringAsFixed(1)));
        _c.text = fmtNum(double.parse(m.carbs.toStringAsFixed(1)));
      }
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final food = CustomFood(
      id: _f?.id,
      kind: CustomFoodKind.product,
      name: _name.text.trim(),
      per100: _per100!,
      portionG: (_portion ?? 0) > 0 ? _portion : null,
      mealTypes: [for (final m in MealType.values) if (_meals.contains(m)) m],
      photo: _photo,
    );
    final id = await widget.foods.save(food);
    if (!mounted) return;
    Navigator.of(context).pop(CustomFood(
      id: id,
      kind: food.kind,
      name: food.name,
      per100: food.per100,
      portionG: food.portionG,
      mealTypes: food.mealTypes,
      photo: food.photo,
    ));
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить продукт?'),
        content: Text('«${_f!.name}» пропадёт из рецептов. Записи в дневнике останутся.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Отмена')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Удалить')),
        ],
      ),
    );
    if (ok != true) return;
    await widget.foods.delete(_f!);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget num(TextEditingController t, String label, {String? suffix, Key? key}) => Expanded(
          child: TextField(
            key: key,
            controller: t,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
            decoration: InputDecoration(labelText: label, suffixText: suffix, isDense: true),
            onChanged: (_) => setState(() {}),
          ),
        );
    final per100 = _per100;
    final portion = _portion;
    return Scaffold(
      appBar: AppBar(
        title: Text(_f == null ? 'Свой продукт' : 'Продукт'),
        actions: [
          if (_f != null)
            IconButton(tooltip: 'Удалить', icon: const Icon(Icons.delete_outline), onPressed: _delete),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _PhotoBox(
            photo: _photo,
            onCamera: () => _pickPhoto(ImageSource.camera),
            onGallery: () => _pickPhoto(ImageSource.gallery),
            onRemove: _photo == null ? null : () => setState(() => _photo = null),
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('food-name'),
            controller: _name,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Название',
              hintText: 'Пельмени «Сибирские», сырники замороженные…',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          Row(children: [
            num(_weight, 'Вес упаковки или порции', suffix: 'г', key: const Key('food-weight')),
          ]),
          const SizedBox(height: 16),
          Text('КБЖУ с этикетки', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<_MacroBasis>(
            segments: const [
              ButtonSegment(value: _MacroBasis.per100, label: Text('на 100 г')),
              ButtonSegment(value: _MacroBasis.perPortion, label: Text('на упаковку / порцию')),
            ],
            selected: {_basis},
            showSelectedIcon: false,
            onSelectionChanged: (s) => _switchBasis(s.first),
          ),
          if (_basis == _MacroBasis.perPortion && (portion == null || portion <= 0))
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Укажите вес упаковки или порции — по нему посчитаем КБЖУ на 100 г.',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
              ),
            ),
          const SizedBox(height: 8),
          Row(children: [
            num(_kcal, 'Ккал', key: const Key('food-kcal')),
            const SizedBox(width: 8),
            num(_p, 'Белки', suffix: 'г', key: const Key('food-protein')),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            num(_fat, 'Жиры', suffix: 'г', key: const Key('food-fat')),
            const SizedBox(width: 8),
            num(_c, 'Углеводы', suffix: 'г', key: const Key('food-carbs')),
          ]),
          if (per100 != null) ...[
            const SizedBox(height: 12),
            Text('На 100 г: ${per100.format()}', style: theme.textTheme.bodyMedium),
            if (portion != null && portion > 0)
              MacroLine(per100 * (portion / 100), style: theme.textTheme.bodySmall),
          ],
          const SizedBox(height: 16),
          Text('Когда подходит', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: [
              for (final m in MealType.values)
                FilterChip(
                  label: Text(m.label),
                  selected: _meals.contains(m),
                  onSelected: (v) => setState(() => _meals = v ? ({..._meals, m}) : ({..._meals}..remove(m))),
                ),
            ],
          ),
          Text('Ничего не выбрано — подходит для любого приёма пищи.', style: theme.textTheme.bodySmall),
          const SizedBox(height: 24),
          FilledButton.icon(
            key: const Key('food-save'),
            onPressed: _valid && !_saving ? _save : null,
            icon: const Icon(Icons.check),
            label: const Text('Сохранить'),
          ),
          const SizedBox(height: 8),
          Text(
            'Продукт появится в «Рецептах» (сборник «Мои продукты»): его можно отметить '
            'съеденным, добавить в план, а купленные упаковки — в «Продукты».',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _PhotoBox extends StatelessWidget {
  const _PhotoBox({required this.photo, required this.onCamera, required this.onGallery, this.onRemove});

  final Uint8List? photo;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 180,
            width: double.infinity,
            color: theme.colorScheme.surfaceContainerHigh,
            child: photo == null
                ? Icon(Icons.photo_camera_outlined, size: 48, color: theme.colorScheme.onSurfaceVariant)
                : Image.memory(photo!, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          children: [
            OutlinedButton.icon(onPressed: onCamera, icon: const Icon(Icons.photo_camera), label: const Text('Снять')),
            OutlinedButton.icon(onPressed: onGallery, icon: const Icon(Icons.photo_library), label: const Text('Из галереи')),
            if (onRemove != null)
              TextButton.icon(onPressed: onRemove, icon: const Icon(Icons.close), label: const Text('Убрать')),
          ],
        ),
      ],
    );
  }
}
