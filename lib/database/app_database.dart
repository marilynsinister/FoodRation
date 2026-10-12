import 'package:drift/drift.dart';

import 'package:food_ration/database/tables/book_advisory.dart';
import 'package:food_ration/database/tables/book_cooking.dart';
import 'package:food_ration/database/tables/book_formulas.dart';
import 'package:food_ration/database/tables/book_meal_plans.dart';
import 'package:food_ration/database/tables/food_items.dart';
import 'package:food_ration/database/tables/meal_planner.dart';
import 'package:food_ration/database/tables/nutrient_catalog.dart';
import 'package:food_ration/database/tables/nutrition_diary.dart';
import 'package:food_ration/database/tables/pdf_meal_ration_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    FoodItems,
    Nutrients,
    Products,
    ProductNutrientValues,
    FormulaDefinitions,
    ActivityLevels,
    MacroNormTemplates,
    CalorieDeficitPolicies,
    CookingYieldFactors,
    AdvisoryRules,
    MealPlanTemplates,
    MealPlanMeals,
    MealPlanLines,
    PdfMealPlans,
    PdfMealPlanDays,
    PdfRecipes,
    PdfSimpleProducts,
    PdfMediaAssets,
    PdfMealSlots,
    PdfRecipeIngredients,
    PdfRecipeSteps,
    PdfRecipeNutrition,
    PdfRecipeMedia,
    PdfSimpleProductNutrition,
    PdfMealSlotItems,
    UserProfiles,
    LoggedMeals,
    PlanEntries,
    PantryItems,
    SettingsEntries,
    CustomFoods,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(nutrients);
            await m.createTable(products);
            await m.createTable(productNutrientValues);
            await m.createTable(formulaDefinitions);
            await m.createTable(activityLevels);
            await m.createTable(macroNormTemplates);
            await m.createTable(calorieDeficitPolicies);
            await m.createTable(cookingYieldFactors);
            await m.createTable(advisoryRules);
            await m.createTable(mealPlanTemplates);
            await m.createTable(mealPlanMeals);
            await m.createTable(mealPlanLines);
          }
          if (from < 3) {
            await m.createTable(pdfMealPlans);
            await m.createTable(pdfMealPlanDays);
            await m.createTable(pdfRecipes);
            await m.createTable(pdfSimpleProducts);
            await m.createTable(pdfMediaAssets);
            await m.createTable(pdfMealSlots);
            await m.createTable(pdfRecipeIngredients);
            await m.createTable(pdfRecipeSteps);
            await m.createTable(pdfRecipeNutrition);
            await m.createTable(pdfRecipeMedia);
            await m.createTable(pdfSimpleProductNutrition);
            await m.createTable(pdfMealSlotItems);
          }
          if (from < 4) {
            await m.createTable(userProfiles);
            await m.createTable(loggedMeals);
          }
          if (from < 5) {
            await m.createTable(planEntries);
            await m.createTable(pantryItems);
            await m.createTable(settingsEntries);
          }
          if (from < 6) {
            await m.createTable(customFoods);
          }
        },
      );
}
