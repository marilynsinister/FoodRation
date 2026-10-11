// Импорт PDF-рациона в SQLite (тот же файл, что использует приложение на Windows).
//
// Важно: чистый `dart run` на Windows не подхватывает pdfium.dll — используйте тест:
//   flutter test test/import_1300_1_pdf_test.dart
//
// Либо (если настроен PDFIUM_PATH и pdfium.dll в PATH):
//   dart run tool/import_meal_plan_pdf.dart [путь_к.pdf] [путь_к.sqlite]
//
// По умолчанию:
//   PDF:  C:\Users\Admin\Documents\1300_3 (21 день).pdf
//   БД:   D:\Android\DB\FoodRation\food_ration.sqlite

import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/meal_ration_import/meal_ration_import.dart';

Future<void> main(List<String> args) async {
  final pdfPath = args.isNotEmpty
      ? args[0]
      : r'C:\Users\Admin\Documents\1300_3 (21 день).pdf';
  final dbPath = args.length > 1
      ? args[1]
      : r'D:\Android\DB\FoodRation\food_ration.sqlite';

  final pdf = File(pdfPath);
  if (!await pdf.exists()) {
    stderr.writeln('Файл PDF не найден: $pdfPath');
    exit(1);
  }

  final dbFile = File(dbPath);
  await dbFile.parent.create(recursive: true);

  final executor = NativeDatabase(
    dbFile,
    setup: (raw) => raw.execute('PRAGMA foreign_keys = ON;'),
  );
  final db = AppDatabase(executor);
  try {
    stdout.writeln('Импорт: $pdfPath');
    stdout.writeln('БД:     $dbPath');
    final result = await importMealPlanFromPdfFile(
      db,
      pdfPath,
      title: p.basenameWithoutExtension(pdfPath),
      sourceFileName: p.basename(pdfPath),
    );
    stdout.writeln('Готово. meal_plans.id = ${result.mealPlanId}');
  } finally {
    await db.close();
  }
}
