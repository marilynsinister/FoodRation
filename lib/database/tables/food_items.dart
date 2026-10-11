import 'package:drift/drift.dart';

/// Пример сущности для локального рациона (заготовка под дальнейшую логику).
class FoodItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 200)();

  IntColumn get calories => integer().withDefault(const Constant(0))();

  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();
}
