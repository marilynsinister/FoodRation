import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/meal_ration_import/meal_plan_pdf_pipeline.dart';

/// Импорт PDF в ту же БД, что у приложения на Windows ([open_connection_io]).
/// Запуск: `flutter test test/import_1300_1_pdf_test.dart`
void main() {
  test('import Documents/1300_1 (21 день).pdf', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    final pdfPath = r'C:\Users\Admin\Documents\1300_1 (21 день).pdf';
    final dbPath = r'D:\Android\DB\FoodRation\food_ration.sqlite';

    if (!File(pdfPath).existsSync()) {
      fail('Нет файла PDF: $pdfPath');
    }

    await Directory(p.dirname(dbPath)).create(recursive: true);

    final db = AppDatabase(
      NativeDatabase(
        File(dbPath),
        setup: (raw) => raw.execute('PRAGMA foreign_keys = ON;'),
      ),
    );
    addTearDown(() async {
      await db.close();
    });

    final result = await importMealPlanFromPdfFile(
      db,
      pdfPath,
      title: '1300_1 (21 день)',
      sourceFileName: p.basename(pdfPath),
    );

    expect(result.mealPlanId, greaterThan(0));
  });
}
