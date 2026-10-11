import 'package:drift/drift.dart';

/// Qualitative guidance (vacation, restaurant, holidays); not fully automatable.
class AdvisoryRules extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get ruleType => text().withLength(max: 64)();

  /// JSON array of tags, e.g. ["vacation","restaurant"]
  TextColumn get contextTags => text().nullable()();

  TextColumn get conditionText => text().nullable()();

  TextColumn get severity => text().withLength(max: 32).nullable()();

  TextColumn get recommendation => text()();

  BoolColumn get isAutomatable => boolean().withDefault(const Constant(false))();

  TextColumn get sourceRef => text().nullable()();
}
