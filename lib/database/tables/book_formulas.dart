import 'package:drift/drift.dart';

/// Declarative formulas (e.g. Mifflin–St Jeor); evaluate in Dart, do not execute SQL from strings.
class FormulaDefinitions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text().unique()();

  TextColumn get name => text()();

  /// Human-readable template, e.g. "[9.99*weight_kg]+[6.25*height_cm]-[4.92*age_years]+5"
  TextColumn get expressionTemplate => text()();

  TextColumn get variableDescription => text().nullable()();

  TextColumn get applicationNotes => text().nullable()();
}

/// Physical activity multipliers from chapter 20.
class ActivityLevels extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text().unique()();

  RealColumn get multiplierMin => real()();

  RealColumn get multiplierMax => real()();

  TextColumn get description => text()();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

/// WHO % ranges, athlete % ranges, or g/kg presets from the book.
class MacroNormTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text().unique()();

  /// who_percent | athlete_percent | g_per_kg_remainder_carbs
  TextColumn get normType => text().withLength(max: 48)();

  /// male | female | any
  TextColumn get sex => text().withLength(max: 16).nullable()();

  RealColumn get carbMinPct => real().nullable()();

  RealColumn get carbMaxPct => real().nullable()();

  RealColumn get fatMinPct => real().nullable()();

  RealColumn get fatMaxPct => real().nullable()();

  RealColumn get proteinMinPct => real().nullable()();

  RealColumn get proteinMaxPct => real().nullable()();

  RealColumn get proteinGPerKgMin => real().nullable()();

  RealColumn get proteinGPerKgMax => real().nullable()();

  RealColumn get fatGPerKgMin => real().nullable()();

  RealColumn get fatGPerKgMax => real().nullable()();

  /// kcal per gram protein/carbs (book: 4.1) and fat (9.3)
  RealColumn get kcalPerGramProtein => real().nullable()();

  RealColumn get kcalPerGramCarb => real().nullable()();

  RealColumn get kcalPerGramFat => real().nullable()();

  TextColumn get notes => text().nullable()();
}

/// Deficit ranges and weekly adjustment heuristics from chapter 20.
class CalorieDeficitPolicies extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get code => text().unique()();

  RealColumn get deficitPercentMin => real().nullable()();

  RealColumn get deficitPercentMax => real().nullable()();

  IntColumn get rollingAverageDaysMin => integer().nullable()();

  IntColumn get rollingAverageDaysRecommended => integer().nullable()();

  RealColumn get weeklyWeightLossOkKg => real().nullable()();

  RealColumn get weeklyWeightLossTooFastKg => real().nullable()();

  IntColumn get adjustmentAddCaloriesWhenTooFast => integer().nullable()();

  RealColumn get adjustmentExtraDeficitPercentWhenSlow => real().nullable()();

  TextColumn get rationaleText => text().nullable()();
}
