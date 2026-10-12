import 'package:drift/drift.dart';

import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/nutrition/recipe.dart';

import 'planner_repository.dart';

class DriftPlannerRepository implements PlannerRepository {
  DriftPlannerRepository(this.db);

  final AppDatabase db;

  @override
  Stream<List<PlanEntry>> watchPlan() {
    final q = db.select(db.planEntries)
      ..orderBy([(t) => OrderingTerm.asc(t.dayKey), (t) => OrderingTerm.asc(t.id)]);
    return q.watch().map((rows) => [
          for (final r in rows)
            PlanEntry(
              id: r.id,
              dayKey: r.dayKey,
              meal: MealType.tryParse(r.mealType) ?? MealType.snack,
              recipeKey: r.recipeKey,
              servings: r.servings,
              done: r.done,
            ),
        ]);
  }

  @override
  Future<void> addPlanEntry(PlanEntry e) async {
    await db.into(db.planEntries).insert(
          PlanEntriesCompanion.insert(
            dayKey: e.dayKey,
            mealType: e.meal.name,
            recipeKey: e.recipeKey,
            servings: Value(e.servings),
            done: Value(e.done),
          ),
        );
  }

  @override
  Future<void> updatePlanEntry(PlanEntry e) async {
    await (db.update(db.planEntries)..where((t) => t.id.equals(e.id!))).write(
      PlanEntriesCompanion(servings: Value(e.servings), done: Value(e.done)),
    );
  }

  @override
  Future<void> deletePlanEntry(int id) async {
    await (db.delete(db.planEntries)..where((t) => t.id.equals(id))).go();
  }

  @override
  Stream<List<PantryItem>> watchPantry() {
    final q = db.select(db.pantryItems)..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return q.watch().map((rows) => [
          for (final r in rows)
            PantryItem(id: r.id, name: r.name, amount: r.amount, unit: PantryUnit.parse(r.unit)),
        ]);
  }

  @override
  Future<void> savePantryItem(PantryItem item) async {
    final companion = PantryItemsCompanion(
      name: Value(item.name),
      amount: Value(item.amount),
      unit: Value(item.unit.name),
      updatedAt: Value(DateTime.now()),
    );
    if (item.id == null) {
      await db.into(db.pantryItems).insert(companion);
    } else {
      await (db.update(db.pantryItems)..where((t) => t.id.equals(item.id!))).write(companion);
    }
  }

  @override
  Future<void> deletePantryItem(int id) async {
    await (db.delete(db.pantryItems)..where((t) => t.id.equals(id))).go();
  }
}
