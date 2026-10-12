import 'package:drift/drift.dart';

/// Блюдо в недельном меню.
@DataClassName('PlanEntryRow')
class PlanEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Локальная дата в формате yyyy-MM-dd.
  TextColumn get dayKey => text()();

  /// breakfast | lunch | snack | dinner
  TextColumn get mealType => text()();

  /// Ключ рецепта из assets/recipes/recipes.json.
  TextColumn get recipeKey => text()();

  /// Сколько порций готовится (ингредиенты списываются на все порции).
  RealColumn get servings => real().withDefault(const Constant(1))();

  /// Приготовлено: продукты уже списаны из запасов.
  BoolColumn get done => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Купленные продукты и их текущий остаток.
@DataClassName('PantryItemRow')
class PantryItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  /// В граммах (g), миллилитрах (ml) или штуках (pcs).
  RealColumn get amount => real()();

  TextColumn get unit => text()();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Настройки приложения: ключ — значение.
@DataClassName('SettingRow')
class SettingsEntries extends Table {
  TextColumn get key => text()();

  TextColumn get value => text()();

  @override
  Set<Column<Object>>? get primaryKey => {key};
}

/// Свои продукты (полуфабрикаты) и блюда, собранные из ингредиентов.
@DataClassName('CustomFoodRow')
class CustomFoods extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// product | dish
  TextColumn get kind => text()();

  TextColumn get name => text()();

  /// КБЖУ на 100 г.
  RealColumn get kcal => real()();

  RealColumn get protein => real()();

  RealColumn get fat => real()();

  RealColumn get carbs => real()();

  /// Вес порции / упаковки, г.
  RealColumn get portionG => real().nullable()();

  /// Вес готового блюда, г (для блюд).
  RealColumn get totalWeightG => real().nullable()();

  /// Ингредиенты блюда: JSON [{"name": ..., "grams": ..., "per100": [к, б, ж, у]}].
  TextColumn get partsJson => text().nullable()();

  /// Коды приёмов пищи через запятую; пусто — все.
  TextColumn get mealTypes => text().withDefault(const Constant(''))();

  BlobColumn get photo => blob().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
