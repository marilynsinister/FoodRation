# Промпт: сгенерировать Drift-таблицы по зафиксированной схеме

Используй **после** того, как отдельным проходом извлечены сущности из книги и согласована реляционная модель (или после правок в этом репозитории).

## Входные данные для модели

1. Список таблиц и полей из проекта FoodRation:
   - `lib/database/tables/nutrient_catalog.dart` — `Nutrients`, `Products`, `ProductNutrientValues`
   - `lib/database/tables/book_formulas.dart` — `FormulaDefinitions`, `ActivityLevels`, `MacroNormTemplates`, `CalorieDeficitPolicies`
   - `lib/database/tables/book_cooking.dart` — `CookingYieldFactors`
   - `lib/database/tables/book_advisory.dart` — `AdvisoryRules`
   - `lib/database/tables/book_meal_plans.dart` — `MealPlanTemplates`, `MealPlanMeals`, `MealPlanLines`
   - `lib/database/tables/food_items.dart` — `FoodItems` (дневник пользователя)
2. Файл сидов JSON: `assets/book_seed/rovenskaya_2021.json` (ключи массивов и смысл полей).

## Задача

Сгенерируй **только** Dart-код Drift:

- Классы `extends Table` с `IntColumn`, `TextColumn`, `RealColumn`, `BoolColumn`, `DateTimeColumn` где уместно.
- `references(..., onDelete: KeyAction.cascade)` для внешних ключей.
- `autoIncrement()`, `nullable()`, `withLength()`, `withDefault`, `unique()` / `@TableIndex` для составных уникальных ограничений.
- Не дублируй уже существующие файлы без причины: если меняется схема, покажи **дифф** или полные заменённые классы и обновлённый `@DriftDatabase(tables: [...])` в `app_database.dart`.
- Укажи новое значение `schemaVersion` и тело `onUpgrade` для `Migrator` (создание новых таблиц / `alterTable` при добавлении колонок).

## Ограничения

- Имена таблиц и колонок в БД — **snake_case** (как выводит Drift), в Dart — **camelCase**.
- Не выполняй произвольный SQL из пользовательских строк; формулы хранить как текст шаблона, расчёт — в Dart.
- Не придумывай данные книги; для наполнения используй JSON-сиды или отдельный импорт.

## Выход

1. Фрагменты `*.dart` для таблиц (или целые файлы).
2. Обновлённый `app_database.dart` с `MigrationStrategy`.
3. Команда для кода: `dart run build_runner build --delete-conflicting-outputs`.
