import 'package:food_ration/database/app_database.dart';

import 'meal_plan_db_importer.dart';
import 'parsed_meal_plan.dart';

const _mealEnToRu = {
  'breakfast': 'Завтрак',
  'lunch': 'Обед',
  'snack': 'Перекус',
  'dinner': 'Ужин',
  'other': 'Приём пищи',
};

double? _toDouble(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

int? _toInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  return int.tryParse(v.toString());
}

Map<String, ParsedRecipe> _recipesFromJson(Map<String, dynamic> json) {
  final shells = <String, Map<String, dynamic>>{};
  for (final e in json['recipes'] as List<dynamic>? ?? []) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final name = m['canonicalName'] as String? ?? '';
    if (name.isEmpty) continue;
    shells[name] = m;
  }

  final ingredientsByRecipe = <String, List<({int order, ParsedIngredientLine line})>>{};
  for (final e in json['ingredients'] as List<dynamic>? ?? []) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final rc = m['recipeCanonicalName'] as String?;
    if (rc == null || !shells.containsKey(rc)) continue;
    final sort = _toInt(m['sortOrder']) ?? 0;
    final ing = ParsedIngredientLine(
      raw: m['ingredientNameRaw'] as String? ?? '',
      amount: _toDouble(m['amount']),
      unit: m['unit'] as String?,
      amountText: m['amountText'] as String?,
      preparationState: m['preparationState'] as String?,
    );
    ingredientsByRecipe.putIfAbsent(rc, () => []).add((order: sort, line: ing));
  }
  for (final list in ingredientsByRecipe.values) {
    list.sort((a, b) => a.order.compareTo(b.order));
  }

  final stepsByRecipe = <String, List<ParsedStep>>{};
  for (final e in json['steps'] as List<dynamic>? ?? []) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final rc = m['recipeCanonicalName'] as String?;
    if (rc == null || !shells.containsKey(rc)) continue;
    final n = _toInt(m['stepNumber']) ?? 0;
    stepsByRecipe.putIfAbsent(rc, () => []).add(
          ParsedStep(
            number: n,
            text: m['instructionText'] as String? ?? '',
            timeMinutes: _toInt(m['timeMinutes']),
            temperatureC: _toInt(m['temperatureC']),
          ),
        );
  }
  for (final list in stepsByRecipe.values) {
    list.sort((a, b) => a.number.compareTo(b.number));
  }

  final recipes = <String, ParsedRecipe>{};
  for (final e in shells.entries) {
    final name = e.key;
    final m = e.value;
    final norm = (m['normalizedName'] as String?) ??
        name.toLowerCase().replaceAll(RegExp(r'[«»"„]'), '').trim();
    recipes[name] = ParsedRecipe(
      canonicalName: name,
      normalizedName: norm,
      ingredients: (ingredientsByRecipe[name] ?? const [])
          .map((e) => e.line)
          .toList(),
      steps: List<ParsedStep>.from(stepsByRecipe[name] ?? const []),
      yieldServings: _toDouble(m['yieldServings']),
      yieldText: m['yieldText'] as String?,
      pageStart: _toInt(m['sourcePageStart']),
      pageEnd: _toInt(m['sourcePageEnd']),
    );
  }
  return recipes;
}

ParsedImportBundle parsedMealPlanFromJson(Map<String, dynamic> json) {
  final metaMap =
      Map<String, dynamic>.from(json['mealPlan'] as Map? ?? const {});
  final meta = ParsedMealPlanMeta(author: metaMap['author'] as String?);
  final n = metaMap['notes'];
  if (n != null) meta.introNotes.writeln(n.toString());

  final recipeByName = _recipesFromJson(json);

  final daysMap = <int, ParsedDay>{};
  for (final e in json['days'] as List<dynamic>? ?? []) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final dn = _toInt(m['dayNumber']) ?? 0;
    if (dn <= 0) continue;
    final d = ParsedDay(dayNumber: dn);
    d.dailyKcal = _toDouble(m['dailyKcal']);
    d.dailyProtein = _toDouble(m['dailyProtein']);
    d.dailyFat = _toDouble(m['dailyFat']);
    d.dailyCarbs = _toDouble(m['dailyCarbs']);
    daysMap[dn] = d;
  }

  final slotsByDay = <int, List<Map<String, dynamic>>>{};
  for (final e in json['mealSlots'] as List<dynamic>? ?? []) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final dn = _toInt(m['dayNumber']) ?? 0;
    if (dn <= 0) continue;
    slotsByDay.putIfAbsent(dn, () => []).add(m);
  }
  for (final list in slotsByDay.values) {
    list.sort(
      (a, b) => (_toInt(a['orderIndex']) ?? 0)
          .compareTo(_toInt(b['orderIndex']) ?? 0),
    );
  }

  ParsedSlot slotFromJson(Map<String, dynamic> sm) {
    final mealType = sm['mealType'] as String? ?? 'other';
    return ParsedSlot(
      mealType: mealType,
      displayNameRu: _mealEnToRu[mealType] ?? mealType,
      orderIndex: _toInt(sm['orderIndex']) ?? 0,
      slotKcal: _toDouble(sm['slotKcal']),
      slotProtein: _toDouble(sm['slotProtein']),
      slotFat: _toDouble(sm['slotFat']),
      slotCarbs: _toDouble(sm['slotCarbs']),
    );
  }

  for (final entry in slotsByDay.entries) {
    final day = daysMap.putIfAbsent(entry.key, () => ParsedDay(dayNumber: entry.key));
    for (final sm in entry.value) {
      day.slots.add(slotFromJson(sm));
    }
  }

  ParsedSlot ensureSlot(ParsedDay day, String mealType) {
    for (final s in day.slots) {
      if (s.mealType == mealType) return s;
    }
    final slot = ParsedSlot(
      mealType: mealType,
      displayNameRu: _mealEnToRu[mealType] ?? mealType,
      orderIndex: day.slots.length,
    );
    day.slots.add(slot);
    return slot;
  }

  for (final e in json['mealSlotItems'] as List<dynamic>? ?? []) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final dn = _toInt(m['dayNumber']) ?? 0;
    final mealType = m['mealType'] as String? ?? 'other';
    final day = daysMap[dn];
    if (day == null) continue;
    final slot = ensureSlot(day, mealType);
    final itemType = m['itemType'] as String? ?? 'recipe';
    final display = m['displayName'] as String? ?? '';
    final pf = _toDouble(m['portionFraction']) ?? 1.0;
    final rc = m['recipeCanonicalName'] as String?;

    if (itemType == 'recipe' && rc != null && recipeByName.containsKey(rc)) {
      slot.items.add(
        ParsedSlotItem(
          displayName: display.isEmpty ? rc : display,
          portionFraction: pf,
          recipe: recipeByName[rc],
        ),
      );
    } else if (itemType == 'simple_product') {
      slot.items.add(
        ParsedSlotItem(
          displayName: display.isEmpty ? 'Product' : display,
          portionFraction: pf,
          simpleRaw: display,
        ),
      );
    } else {
      final r = rc != null ? recipeByName[rc] : null;
      slot.items.add(
        ParsedSlotItem(
          displayName: display.isEmpty ? 'Item' : display,
          portionFraction: pf,
          recipe: r,
          simpleRaw: r == null ? display : null,
        ),
      );
    }
  }

  final days = daysMap.keys.toList()..sort();
  return ParsedImportBundle(
    meta: meta,
    days: days.map((k) => daysMap[k]!).toList(),
  );
}

/// Imports the intermediate JSON shape (see plan) using the same path as PDF parse.
Future<MealPlanDbImportResult> importMealPlanFromJson(
  AppDatabase db,
  Map<String, dynamic> json, {
  String? sourceFileName,
  Map<int, int>? pageNumberToMediaAssetId,
}) {
  final bundle = parsedMealPlanFromJson(json);
  final meta = Map<String, dynamic>.from(json['mealPlan'] as Map? ?? const {});
  final title = meta['title'] as String?;
  return importParsedMealPlanBundle(
    db,
    bundle,
    sourceFileName: sourceFileName ?? meta['sourceFileName'] as String?,
    title: title,
    pageNumberToMediaAssetId: pageNumberToMediaAssetId,
  );
}
