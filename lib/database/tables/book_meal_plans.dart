import 'package:drift/drift.dart';

/// Example day plans from chapter 22 (book metadata + daily targets).
class MealPlanTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text().unique()();

  TextColumn get title => text()();

  TextColumn get sourceBook => text().nullable()();

  TextColumn get chapterRef => text().nullable()();

  IntColumn get exampleNumber => integer().nullable()();

  IntColumn get dayNumber => integer().nullable()();

  RealColumn get targetCalories => real().nullable()();

  RealColumn get targetProteinG => real().nullable()();

  RealColumn get targetFatG => real().nullable()();

  RealColumn get targetCarbG => real().nullable()();
}

/// One eating occasion inside a template (breakfast, lunch, …).
class MealPlanMeals extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get templateId =>
      integer().references(MealPlanTemplates, #id, onDelete: KeyAction.cascade)();

  IntColumn get sortOrder => integer()();

  TextColumn get mealLabel => text()();

  RealColumn get calories => real().nullable()();

  RealColumn get proteinG => real().nullable()();

  RealColumn get fatG => real().nullable()();

  RealColumn get carbG => real().nullable()();
}

/// Dish titles, ingredients, or short instructions for a meal row.
class MealPlanLines extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mealId => integer().references(MealPlanMeals, #id, onDelete: KeyAction.cascade)();

  IntColumn get sortOrder => integer()();

  /// dish_title | ingredient | note
  TextColumn get lineType => text().withLength(max: 32)();

  TextColumn get content => text()();

  RealColumn get amountGrams => real().nullable()();

  TextColumn get amountText => text().nullable()();
}
