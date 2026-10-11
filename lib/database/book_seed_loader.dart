import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:food_ration/database/app_database.dart';

/// Loads structured fragments from [assetPath] once (when [Nutrients] is empty).
class BookSeedLoader {
  BookSeedLoader._();

  static const String assetPath = 'assets/book_seed/rovenskaya_2021.json';

  static Future<void> seedFromAssetIfEmpty(AppDatabase db) async {
    final countQuery = db.selectOnly(db.nutrients)..addColumns([db.nutrients.id.count()]);
    final count = await countQuery.map((row) => row.read(db.nutrients.id.count())).getSingle();
    if (count != null && count > 0) {
      return;
    }

    try {
      final raw = await rootBundle.loadString(assetPath);
      final data = jsonDecode(raw) as Map<String, dynamic>;
      await _applyBookSeed(db, data);
    } catch (e, st) {
      debugPrint('BookSeedLoader: skipped or failed ($e)\n$st');
    }
  }

  static Future<void> _applyBookSeed(AppDatabase db, Map<String, dynamic> data) async {
    await db.transaction(() async {
      final nutrientByCode = <String, int>{};
      for (final row in _listMap(data['nutrients'])) {
        await db.into(db.nutrients).insert(
              NutrientsCompanion.insert(
                code: row['code']! as String,
                name: row['name']! as String,
                unit: row['unit']! as String,
                nutrientType: row['nutrient_type']! as String,
                description: Value(row['description'] as String?),
              ),
            );
      }
      for (final n in await db.select(db.nutrients).get()) {
        nutrientByCode[n.code] = n.id;
      }

      final productByCode = <String, int>{};
      for (final row in _listMap(data['products'])) {
        final code = row['code']! as String;
        final pid = await db.into(db.products).insert(
              ProductsCompanion.insert(
                name: row['name']! as String,
                source: row['source']! as String,
                normalizedName: Value(row['normalized_name'] as String?),
                category: Value(row['category'] as String?),
                subcategory: Value(row['subcategory'] as String?),
                description: Value(row['description'] as String?),
                defaultPortionGrams: Value(_real(row['default_portion_grams'])),
                ediblePartPercent: Value(_real(row['edible_part_percent'])),
                sourceRef: Value(row['source_ref'] as String?),
                notes: Value(row['notes'] as String?),
              ),
            );
        productByCode[code] = pid;
      }

      for (final row in _listMap(data['product_nutrient_values'])) {
        final pc = row['product_code'] as String;
        final nc = row['nutrient_code'] as String;
        final pid = productByCode[pc];
        final nid = nutrientByCode[nc];
        if (pid == null || nid == null) {
          continue;
        }
        await db.into(db.productNutrientValues).insert(
              ProductNutrientValuesCompanion.insert(
                productId: pid,
                nutrientId: nid,
                value: _real(row['value'])!,
                basisType: row['basis_type']! as String,
                basisGrams: Value(_real(row['basis_grams'])),
                unitOverride: Value(row['unit_override'] as String?),
              ),
            );
      }

      for (final row in _listMap(data['formula_definitions'])) {
        await db.into(db.formulaDefinitions).insert(
              FormulaDefinitionsCompanion.insert(
                code: row['code']! as String,
                name: row['name']! as String,
                expressionTemplate: row['expression_template']! as String,
                variableDescription: Value(row['variable_description'] as String?),
                applicationNotes: Value(row['application_notes'] as String?),
              ),
            );
      }

      for (final row in _listMap(data['activity_levels'])) {
        await db.into(db.activityLevels).insert(
              ActivityLevelsCompanion.insert(
                code: row['code']! as String,
                multiplierMin: _real(row['multiplier_min'])!,
                multiplierMax: _real(row['multiplier_max'])!,
                description: row['description']! as String,
                sortOrder: Value(row['sort_order'] as int? ?? 0),
              ),
            );
      }

      for (final row in _listMap(data['macro_norm_templates'])) {
        await db.into(db.macroNormTemplates).insert(
              MacroNormTemplatesCompanion.insert(
                code: row['code']! as String,
                normType: row['norm_type']! as String,
                sex: Value(row['sex'] as String?),
                carbMinPct: Value(_real(row['carb_min_pct'])),
                carbMaxPct: Value(_real(row['carb_max_pct'])),
                fatMinPct: Value(_real(row['fat_min_pct'])),
                fatMaxPct: Value(_real(row['fat_max_pct'])),
                proteinMinPct: Value(_real(row['protein_min_pct'])),
                proteinMaxPct: Value(_real(row['protein_max_pct'])),
                proteinGPerKgMin: Value(_real(row['protein_g_per_kg_min'])),
                proteinGPerKgMax: Value(_real(row['protein_g_per_kg_max'])),
                fatGPerKgMin: Value(_real(row['fat_g_per_kg_min'])),
                fatGPerKgMax: Value(_real(row['fat_g_per_kg_max'])),
                kcalPerGramProtein: Value(_real(row['kcal_per_gram_protein'])),
                kcalPerGramCarb: Value(_real(row['kcal_per_gram_carb'])),
                kcalPerGramFat: Value(_real(row['kcal_per_gram_fat'])),
                notes: Value(row['notes'] as String?),
              ),
            );
      }

      for (final row in _listMap(data['calorie_deficit_policies'])) {
        await db.into(db.calorieDeficitPolicies).insert(
              CalorieDeficitPoliciesCompanion.insert(
                code: row['code']! as String,
                deficitPercentMin: Value(_real(row['deficit_percent_min'])),
                deficitPercentMax: Value(_real(row['deficit_percent_max'])),
                rollingAverageDaysMin: Value(row['rolling_average_days_min'] as int?),
                rollingAverageDaysRecommended: Value(row['rolling_average_days_recommended'] as int?),
                weeklyWeightLossOkKg: Value(_real(row['weekly_weight_loss_ok_kg'])),
                weeklyWeightLossTooFastKg: Value(_real(row['weekly_weight_loss_too_fast_kg'])),
                adjustmentAddCaloriesWhenTooFast: Value(row['adjustment_add_calories_when_too_fast'] as int?),
                adjustmentExtraDeficitPercentWhenSlow: Value(_real(row['adjustment_extra_deficit_percent_when_slow'])),
                rationaleText: Value(row['rationale_text'] as String?),
              ),
            );
      }

      for (final row in _listMap(data['cooking_yield_factors'])) {
        await db.into(db.cookingYieldFactors).insert(
              CookingYieldFactorsCompanion.insert(
                ingredientKey: row['ingredient_key']! as String,
                category: row['category']! as String,
                yieldLossPercent: Value(_real(row['yield_loss_percent'])),
                yieldLossPercentMin: Value(_real(row['yield_loss_percent_min'])),
                yieldLossPercentMax: Value(_real(row['yield_loss_percent_max'])),
                notes: Value(row['notes'] as String?),
              ),
            );
      }

      for (final row in _listMap(data['advisory_rules'])) {
        final tags = row['context_tags'];
        final tagsJson = tags is List ? jsonEncode(tags) : null;
        await db.into(db.advisoryRules).insert(
              AdvisoryRulesCompanion.insert(
                ruleType: row['rule_type']! as String,
                recommendation: row['recommendation']! as String,
                contextTags: Value(tagsJson),
                conditionText: Value(row['condition_text'] as String?),
                severity: Value(row['severity'] as String?),
                isAutomatable: Value(row['is_automatable'] as bool? ?? false),
                sourceRef: Value(row['source_ref'] as String?),
              ),
            );
      }

      for (final plan in _listMap(data['meal_plans'])) {
        final templateId = await db.into(db.mealPlanTemplates).insert(
              MealPlanTemplatesCompanion.insert(
                code: plan['code']! as String,
                title: plan['title']! as String,
                sourceBook: Value(plan['source_book'] as String?),
                chapterRef: Value(plan['chapter_ref'] as String?),
                exampleNumber: Value(plan['example_number'] as int?),
                dayNumber: Value(plan['day_number'] as int?),
                targetCalories: Value(_real(plan['target_calories'])),
                targetProteinG: Value(_real(plan['target_protein_g'])),
                targetFatG: Value(_real(plan['target_fat_g'])),
                targetCarbG: Value(_real(plan['target_carb_g'])),
              ),
            );

        for (final meal in _listMap(plan['meals'])) {
          final mealId = await db.into(db.mealPlanMeals).insert(
                MealPlanMealsCompanion.insert(
                  templateId: templateId,
                  sortOrder: meal['sort_order']! as int,
                  mealLabel: meal['meal_label']! as String,
                  calories: Value(_real(meal['calories'])),
                  proteinG: Value(_real(meal['protein_g'])),
                  fatG: Value(_real(meal['fat_g'])),
                  carbG: Value(_real(meal['carb_g'])),
                ),
              );

          for (final line in _listMap(meal['lines'])) {
            await db.into(db.mealPlanLines).insert(
                  MealPlanLinesCompanion.insert(
                    mealId: mealId,
                    sortOrder: line['sort_order']! as int,
                    lineType: line['line_type']! as String,
                    content: line['content']! as String,
                    amountGrams: Value(_real(line['amount_grams'])),
                    amountText: Value(line['amount_text'] as String?),
                  ),
                );
          }
        }
      }
    });
  }

  static List<Map<String, dynamic>> _listMap(dynamic value) {
    if (value is! List) {
      return [];
    }
    return value.cast<Map<String, dynamic>>();
  }

  static double? _real(dynamic v) {
    if (v == null) {
      return null;
    }
    if (v is num) {
      return v.toDouble();
    }
    return double.tryParse(v.toString());
  }
}
