import 'package:drift/drift.dart';

import 'package:food_ration/database/app_database.dart';

import 'parsed_meal_plan.dart';
import 'recipe_dedup_key.dart';

/// Result of [importParsedMealPlanBundle].
class MealPlanDbImportResult {
  MealPlanDbImportResult({required this.mealPlanId});

  final int mealPlanId;
}

Map<String, ParsedRecipe> _uniqueRecipesByDedupKey(ParsedImportBundle bundle) {
  final map = <String, ParsedRecipe>{};
  for (final d in bundle.days) {
    for (final s in d.slots) {
      for (final it in s.items) {
        final r = it.recipe;
        if (r == null) continue;
        final k = recipeDedupKey(r);
        map.putIfAbsent(k, () => r);
      }
    }
  }
  return map;
}

Future<void> _insertRecipeGraph(
  AppDatabase db,
  ParsedRecipe r,
  int recipeId,
) async {
  var sort = 0;
  for (final ing in r.ingredients) {
    await db.into(db.pdfRecipeIngredients).insert(
          PdfRecipeIngredientsCompanion.insert(
            recipeId: recipeId,
            ingredientNameRaw: ing.raw,
            ingredientNameNormalized: Value(ing.raw.toLowerCase().trim()),
            amount: Value(ing.amount),
            unit: Value(ing.unit),
            amountText: Value(ing.amountText),
            preparationState: Value(ing.preparationState),
            sortOrder: sort++,
          ),
        );
  }
  for (final st in r.steps) {
    await db.into(db.pdfRecipeSteps).insert(
          PdfRecipeStepsCompanion.insert(
            recipeId: recipeId,
            stepNumber: st.number,
            instructionText: st.text,
            timeMinutes: Value(st.timeMinutes),
            temperatureC: Value(st.temperatureC),
          ),
        );
  }
}

Future<void> _linkRecipesToMedia(
  AppDatabase db,
  ParsedImportBundle bundle,
  Map<String, int> dedupKeyToRecipeId,
  Map<int, int> pageToMediaAssetId,
) async {
  final linked = <String, bool>{};
  for (final d in bundle.days) {
    for (final s in d.slots) {
      for (final it in s.items) {
        final r = it.recipe;
        if (r == null) continue;
        final k = recipeDedupKey(r);
        final rid = dedupKeyToRecipeId[k];
        if (rid == null) continue;
        final start = r.pageStart;
        final end = r.pageEnd;
        if (start == null || end == null) continue;
        var order = 0;
        for (var p = start; p <= end; p++) {
          final mid = pageToMediaAssetId[p];
          if (mid == null) continue;
          final pk = '$rid-$mid';
          if (linked.containsKey(pk)) continue;
          linked[pk] = true;
          await db.into(db.pdfRecipeMedia).insert(
                PdfRecipeMediaCompanion.insert(
                  recipeId: rid,
                  mediaAssetId: mid,
                  isPrimary: Value(p == start),
                  sortOrder: Value(order++),
                ),
                mode: InsertMode.insertOrIgnore,
              );
        }
      }
    }
  }
}

/// Inserts [bundle] into Drift tables in a single transaction.
Future<MealPlanDbImportResult> importParsedMealPlanBundle(
  AppDatabase db,
  ParsedImportBundle bundle, {
  String? sourceFileName,
  String? title,
  Map<int, int>? pageNumberToMediaAssetId,
}) async {
  final intro = bundle.meta.introNotes.toString().trim();
  final notes = <String>[
    if (intro.isNotEmpty) intro,
    if (bundle.shoppingBasketRaw != null)
      'Продуктовая корзина:\n${bundle.shoppingBasketRaw}',
  ].join('\n\n');

  return db.transaction(() async {
    final planId = await db.into(db.pdfMealPlans).insert(
          PdfMealPlansCompanion.insert(
            title: title ?? sourceFileName ?? 'Imported meal plan',
            sourceFileName: Value(sourceFileName),
            author: Value(bundle.meta.author),
            daysCount: Value(bundle.days.length),
            notes: Value(notes.isEmpty ? null : notes),
          ),
        );

    final unique = _uniqueRecipesByDedupKey(bundle);
    final dedupKeyToId = <String, int>{};

    for (final e in unique.entries) {
      final k = e.key;
      final r = e.value;
      final existing = await (db.select(db.pdfRecipes)
            ..where((t) => t.deduplicationKey.equals(k)))
          .getSingleOrNull();
      if (existing != null) {
        dedupKeyToId[k] = existing.id;
        continue;
      }
      final rid = await db.into(db.pdfRecipes).insert(
            PdfRecipesCompanion.insert(
              canonicalName: r.canonicalName,
              normalizedName: r.normalizedName,
              yieldServings: Value(r.yieldServings),
              yieldText: Value(r.yieldText),
              sourcePageStart: Value(r.pageStart),
              sourcePageEnd: Value(r.pageEnd),
              cookTimeMinutes: Value(r.cookTimeMinutes),
              deduplicationKey: Value(k),
            ),
          );
      dedupKeyToId[k] = rid;
      await _insertRecipeGraph(db, r, rid);
    }

    final simpleCache = <String, int>{};

    for (final day in bundle.days) {
      final dayId = await db.into(db.pdfMealPlanDays).insert(
            PdfMealPlanDaysCompanion.insert(
              mealPlanId: planId,
              dayNumber: day.dayNumber,
              dailyKcal: Value(day.dailyKcal),
              dailyProtein: Value(day.dailyProtein),
              dailyFat: Value(day.dailyFat),
              dailyCarbs: Value(day.dailyCarbs),
            ),
          );

      for (final slot in day.slots) {
        final slotId = await db.into(db.pdfMealSlots).insert(
              PdfMealSlotsCompanion.insert(
                mealPlanDayId: dayId,
                mealType: slot.mealType,
                displayName: slot.displayNameRu,
                orderIndex: slot.orderIndex,
                slotKcal: Value(slot.slotKcal),
                slotProtein: Value(slot.slotProtein),
                slotFat: Value(slot.slotFat),
                slotCarbs: Value(slot.slotCarbs),
              ),
            );

        for (final item in slot.items) {
          if (item.recipe != null) {
            final k = recipeDedupKey(item.recipe!);
            final rid = dedupKeyToId[k]!;
            await db.into(db.pdfMealSlotItems).insert(
                  PdfMealSlotItemsCompanion.insert(
                    mealSlotId: slotId,
                    itemType: 'recipe',
                    recipeId: Value(rid),
                    displayName: item.displayName,
                    portionFraction: Value(item.portionFraction),
                  ),
                );
          } else if (item.simpleRaw != null && item.simpleRaw!.isNotEmpty) {
            final raw = item.simpleRaw!.trim();
            final norm = raw.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
            if (!simpleCache.containsKey(norm)) {
              simpleCache[norm] = await db.into(db.pdfSimpleProducts).insert(
                    PdfSimpleProductsCompanion.insert(
                      name: raw.length > 120
                          ? '${raw.substring(0, 117)}...'
                          : raw,
                      normalizedName: norm,
                    ),
                  );
            }
            final sid = simpleCache[norm]!;
            await db.into(db.pdfMealSlotItems).insert(
                  PdfMealSlotItemsCompanion.insert(
                    mealSlotId: slotId,
                    itemType: 'simple_product',
                    simpleProductId: Value(sid),
                    displayName: item.displayName,
                    portionFraction: Value(item.portionFraction),
                    amountText: Value(
                      raw.length > 200 ? '${raw.substring(0, 197)}...' : raw,
                    ),
                  ),
                );
          } else {
            await db.into(db.pdfMealSlotItems).insert(
                  PdfMealSlotItemsCompanion.insert(
                    mealSlotId: slotId,
                    itemType: 'combo',
                    displayName: item.displayName,
                    portionFraction: Value(item.portionFraction),
                  ),
                );
          }
        }
      }
    }

    if (pageNumberToMediaAssetId != null &&
        pageNumberToMediaAssetId.isNotEmpty) {
      await _linkRecipesToMedia(
        db,
        bundle,
        dedupKeyToId,
        pageNumberToMediaAssetId,
      );
    }

    return MealPlanDbImportResult(mealPlanId: planId);
  });
}
