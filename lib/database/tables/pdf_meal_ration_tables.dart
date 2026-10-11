import 'package:drift/drift.dart';

/// Imported PDF meal program (separate from [MealPlanTemplates] book examples).
class PdfMealPlans extends Table {
  @override
  String get tableName => 'meal_plans';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get sourceFileName => text().nullable()();

  TextColumn get sourceType => text().withDefault(const Constant('pdf'))();

  TextColumn get author => text().nullable()();

  TextColumn get description => text().nullable()();

  IntColumn get daysCount => integer().nullable()();

  TextColumn get notes => text().nullable()();

  TextColumn get rawSourceReference => text().nullable()();
}

class PdfMealPlanDays extends Table {
  @override
  String get tableName => 'meal_plan_days';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get mealPlanId =>
      integer().references(PdfMealPlans, #id, onDelete: KeyAction.cascade)();

  IntColumn get dayNumber => integer()();

  TextColumn get title => text().nullable()();

  RealColumn get dailyKcal => real().nullable()();

  RealColumn get dailyProtein => real().nullable()();

  RealColumn get dailyFat => real().nullable()();

  RealColumn get dailyCarbs => real().nullable()();

  TextColumn get notes => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {mealPlanId, dayNumber},
      ];
}

class PdfMealSlots extends Table {
  @override
  String get tableName => 'meal_slots';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get mealPlanDayId =>
      integer().references(PdfMealPlanDays, #id, onDelete: KeyAction.cascade)();

  /// breakfast | lunch | snack | dinner | other
  TextColumn get mealType => text()();

  TextColumn get displayName => text()();

  IntColumn get orderIndex => integer()();

  RealColumn get slotKcal => real().nullable()();

  RealColumn get slotProtein => real().nullable()();

  RealColumn get slotFat => real().nullable()();

  RealColumn get slotCarbs => real().nullable()();

  TextColumn get notes => text().nullable()();
}

class PdfRecipes extends Table {
  @override
  String get tableName => 'recipes';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get canonicalName => text()();

  TextColumn get normalizedName => text()();

  TextColumn get recipeType => text().nullable()();

  TextColumn get description => text().nullable()();

  RealColumn get defaultServings => real().nullable()();

  RealColumn get yieldServings => real().nullable()();

  TextColumn get yieldText => text().nullable()();

  IntColumn get cookTimeMinutes => integer().nullable()();

  IntColumn get prepTimeMinutes => integer().nullable()();

  IntColumn get totalTimeMinutes => integer().nullable()();

  TextColumn get difficulty => text().nullable()();

  TextColumn get sourceType => text().nullable()();

  TextColumn get sourceTitle => text().nullable()();

  IntColumn get sourcePageStart => integer().nullable()();

  IntColumn get sourcePageEnd => integer().nullable()();

  BoolColumn get isReusable => boolean().withDefault(const Constant(true))();

  TextColumn get deduplicationKey => text().nullable()();

  TextColumn get notes => text().nullable()();
}

class PdfRecipeIngredients extends Table {
  @override
  String get tableName => 'recipe_ingredients';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get recipeId =>
      integer().references(PdfRecipes, #id, onDelete: KeyAction.cascade)();

  TextColumn get ingredientNameRaw => text()();

  TextColumn get ingredientNameNormalized => text().nullable()();

  RealColumn get amount => real().nullable()();

  TextColumn get unit => text().nullable()();

  TextColumn get amountText => text().nullable()();

  TextColumn get preparationState => text().nullable()();

  BoolColumn get optionalFlag => boolean().withDefault(const Constant(false))();

  IntColumn get sortOrder => integer()();

  TextColumn get notes => text().nullable()();
}

class PdfRecipeSteps extends Table {
  @override
  String get tableName => 'recipe_steps';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get recipeId =>
      integer().references(PdfRecipes, #id, onDelete: KeyAction.cascade)();

  IntColumn get stepNumber => integer()();

  TextColumn get instructionText => text()();

  IntColumn get timeMinutes => integer().nullable()();

  IntColumn get temperatureC => integer().nullable()();

  TextColumn get notes => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {recipeId, stepNumber},
      ];
}

class PdfRecipeNutrition extends Table {
  @override
  String get tableName => 'recipe_nutrition';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get recipeId =>
      integer().references(PdfRecipes, #id, onDelete: KeyAction.cascade)();

  TextColumn get basisType => text()();

  RealColumn get basisValue => real().nullable()();

  RealColumn get kcal => real().nullable()();

  RealColumn get protein => real().nullable()();

  RealColumn get fat => real().nullable()();

  RealColumn get carbs => real().nullable()();

  RealColumn get fiber => real().nullable()();

  TextColumn get provenance => text().withDefault(const Constant('declared'))();

  TextColumn get notes => text().nullable()();
}

class PdfMediaAssets extends Table {
  @override
  String get tableName => 'media_assets';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get sourceFileId => text().nullable()();

  IntColumn get sourcePage => integer().nullable()();

  TextColumn get mediaType => text().withDefault(const Constant('image'))();

  TextColumn get fileName => text().nullable()();

  TextColumn get relativePath => text().nullable()();

  TextColumn get storageUri => text().nullable()();

  TextColumn get caption => text().nullable()();

  TextColumn get altText => text().nullable()();

  IntColumn get width => integer().nullable()();

  IntColumn get height => integer().nullable()();

  TextColumn get hash => text().nullable()();

  TextColumn get notes => text().nullable()();
}

class PdfRecipeMedia extends Table {
  @override
  String get tableName => 'recipe_media';

  IntColumn get recipeId =>
      integer().references(PdfRecipes, #id, onDelete: KeyAction.cascade)();

  IntColumn get mediaAssetId =>
      integer().references(PdfMediaAssets, #id, onDelete: KeyAction.cascade)();

  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {recipeId, mediaAssetId};
}

class PdfSimpleProducts extends Table {
  @override
  String get tableName => 'simple_products';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get normalizedName => text()();

  TextColumn get category => text().nullable()();

  TextColumn get defaultUnit => text().nullable()();

  TextColumn get notes => text().nullable()();
}

class PdfSimpleProductNutrition extends Table {
  @override
  String get tableName => 'simple_product_nutrition';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get simpleProductId =>
      integer().references(PdfSimpleProducts, #id, onDelete: KeyAction.cascade)();

  TextColumn get basisType => text()();

  RealColumn get basisValue => real().nullable()();

  RealColumn get kcal => real().nullable()();

  RealColumn get protein => real().nullable()();

  RealColumn get fat => real().nullable()();

  RealColumn get carbs => real().nullable()();

  TextColumn get provenance => text().withDefault(const Constant('declared'))();

  TextColumn get notes => text().nullable()();
}

class PdfMealSlotItems extends Table {
  @override
  String get tableName => 'meal_slot_items';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get mealSlotId =>
      integer().references(PdfMealSlots, #id, onDelete: KeyAction.cascade)();

  /// recipe | simple_product | combo
  TextColumn get itemType => text()();

  IntColumn get recipeId =>
      integer().nullable().references(PdfRecipes, #id, onDelete: KeyAction.setNull)();

  IntColumn get simpleProductId => integer()
      .nullable()
      .references(PdfSimpleProducts, #id, onDelete: KeyAction.setNull)();

  TextColumn get displayName => text()();

  RealColumn get servings => real().nullable()();

  RealColumn get portionFraction => real().nullable()();

  TextColumn get amountText => text().nullable()();

  RealColumn get itemKcal => real().nullable()();

  RealColumn get itemProtein => real().nullable()();

  RealColumn get itemFat => real().nullable()();

  RealColumn get itemCarbs => real().nullable()();

  TextColumn get notes => text().nullable()();
}
