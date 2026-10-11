import 'dart:io' show exit;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'package:food_ration/app.dart';
import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/database/book_seed_loader.dart';
import 'package:food_ration/database/open_connection.dart';
import 'package:food_ration/meal_ration_import/meal_plan_pdf_pipeline.dart';
import 'package:food_ration/nutrition/drift_nutrition_repository.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/nutrition_repository.dart';
import 'package:food_ration/nutrition/recipe_catalog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final catalog = await RecipeCatalog.loadFromAssets();

  if (kIsWeb) {
    // Drift на вебе не настроен: профиль и дневник живут в памяти до перезагрузки.
    final controller = NutritionController(
      repository: InMemoryNutritionRepository(),
      catalog: catalog,
    );
    await controller.init();
    runApp(FoodRationApp(controller: controller));
    return;
  }

  final database = AppDatabase(openDatabaseConnection());
  await BookSeedLoader.seedFromAssetIfEmpty(database);

  const runPdfImport =
      bool.fromEnvironment('IMPORT_MEAL_PLAN_PDF', defaultValue: false);
  const pdfPathEnv = String.fromEnvironment(
    'IMPORT_PDF_PATH',
    defaultValue: r'C:\Users\Admin\Documents\1300_3 (21 день).pdf',
  );

  if (runPdfImport) {
    try {
      final r = await importMealPlanFromPdfFile(
        database,
        pdfPathEnv,
        title: p.basenameWithoutExtension(pdfPathEnv),
        sourceFileName: p.basename(pdfPathEnv),
      );
      // ignore: avoid_print
      print('Импорт PDF завершён: meal_plans.id = ${r.mealPlanId}');
    } catch (e, st) {
      // ignore: avoid_print
      print('Ошибка импорта PDF: $e\n$st');
      await database.close();
      exit(1);
    }
    await database.close();
    exit(0);
  }

  final controller = NutritionController(
    repository: DriftNutritionRepository(database),
    catalog: catalog,
  );
  await controller.init();
  runApp(FoodRationApp(controller: controller, database: database));
}
