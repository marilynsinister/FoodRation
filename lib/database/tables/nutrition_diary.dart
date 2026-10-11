import 'package:drift/drift.dart';

/// Параметры калькулятора КБЖУ (одна строка, id = 1).
@DataClassName('ProfileRow')
class UserProfiles extends Table {
  IntColumn get id => integer()();

  /// female | male
  TextColumn get sex => text()();

  IntColumn get age => integer()();

  RealColumn get heightCm => real()();

  RealColumn get weightKg => real()();

  /// Код [ActivityLevel].
  TextColumn get activity => text()();

  /// Код [Goal].
  TextColumn get goal => text()();

  RealColumn get customKcal => real().nullable()();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

/// «Сегодня я приготовила / съела»: запись дневника питания.
@DataClassName('LoggedMealRow')
class LoggedMeals extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Локальная дата в формате yyyy-MM-dd.
  TextColumn get dayKey => text()();

  /// breakfast | lunch | snack | dinner
  TextColumn get mealType => text()();

  /// Ключ рецепта из assets/recipes/recipes.json; null для ручной записи.
  TextColumn get recipeKey => text().nullable()();

  TextColumn get title => text()();

  TextColumn get portionLabel => text().nullable()();

  RealColumn get kcal => real()();

  RealColumn get protein => real()();

  RealColumn get fat => real()();

  RealColumn get carbs => real()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
