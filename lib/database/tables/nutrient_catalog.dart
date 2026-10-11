import 'package:drift/drift.dart';

/// Reference nutrients for future EAV; core macros seeded from the book examples.
class Nutrients extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text().unique()();

  TextColumn get name => text()();

  TextColumn get unit => text()();

  /// macro | micro | vitamin | mineral | other
  TextColumn get nutrientType => text().withLength(max: 32)();

  TextColumn get description => text().nullable()();
}

/// Catalog items from the book examples or external sources (not the user diary).
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get normalizedName => text().nullable()();

  TextColumn get category => text().nullable()();

  TextColumn get subcategory => text().nullable()();

  TextColumn get description => text().nullable()();

  RealColumn get defaultPortionGrams => real().nullable()();

  RealColumn get ediblePartPercent => real().nullable()();

  /// book_example | external | user_defined
  TextColumn get source => text().withLength(max: 32)();

  TextColumn get sourceRef => text().nullable()();

  TextColumn get notes => text().nullable()();
}

@TableIndex(
  name: 'product_nutrient_basis_unique',
  columns: {#productId, #nutrientId, #basisType},
  unique: true,
)
class ProductNutrientValues extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer().references(Products, #id, onDelete: KeyAction.cascade)();

  IntColumn get nutrientId => integer().references(Nutrients, #id, onDelete: KeyAction.cascade)();

  RealColumn get value => real()();

  /// per_100g | per_serving
  TextColumn get basisType => text().withLength(max: 32)();

  RealColumn get basisGrams => real().nullable()();

  TextColumn get unitOverride => text().nullable()();
}
