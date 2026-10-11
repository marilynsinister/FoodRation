import 'package:drift/drift.dart';

/// Cooking loss / shrink percentages from the book (уварка, ужарка).
class CookingYieldFactors extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Stable key, e.g. onion, fish, poultry
  TextColumn get ingredientKey => text().unique()();

  /// vegetable | meat | fish | poultry | other
  TextColumn get category => text().withLength(max: 32)();

  RealColumn get yieldLossPercent => real().nullable()();

  RealColumn get yieldLossPercentMin => real().nullable()();

  RealColumn get yieldLossPercentMax => real().nullable()();

  TextColumn get notes => text().nullable()();
}
