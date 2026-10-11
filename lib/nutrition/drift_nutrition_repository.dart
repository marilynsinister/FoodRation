import 'package:drift/drift.dart';

import 'package:food_ration/database/app_database.dart' hide ActivityLevel;

import 'kbju_calculator.dart';
import 'macros.dart';
import 'nutrition_repository.dart';
import 'recipe.dart';

class DriftNutritionRepository implements NutritionRepository {
  DriftNutritionRepository(this.db);

  final AppDatabase db;

  static const _profileId = 1;

  @override
  Future<NutritionProfile?> loadProfile() async {
    final row = await (db.select(db.userProfiles)..where((t) => t.id.equals(_profileId)))
        .getSingleOrNull();
    if (row == null) return null;
    T byName<T extends Enum>(List<T> values, String code, T fallback) =>
        values.firstWhere((v) => v.name == code, orElse: () => fallback);
    return NutritionProfile(
      sex: byName(Sex.values, row.sex, Sex.female),
      age: row.age,
      heightCm: row.heightCm,
      weightKg: row.weightKg,
      activity: byName(ActivityLevel.values, row.activity, ActivityLevel.light),
      goal: byName(Goal.values, row.goal, Goal.maintain),
      customKcal: row.customKcal,
    );
  }

  @override
  Future<void> saveProfile(NutritionProfile p) async {
    await db.into(db.userProfiles).insertOnConflictUpdate(
          UserProfilesCompanion.insert(
            id: const Value(_profileId),
            sex: p.sex.name,
            age: p.age,
            heightCm: p.heightCm,
            weightKg: p.weightKg,
            activity: p.activity.name,
            goal: p.goal.name,
            customKcal: Value(p.customKcal),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Stream<List<DiaryEntry>> watchDay(String dayKey) {
    final q = db.select(db.loggedMeals)
      ..where((t) => t.dayKey.equals(dayKey))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt), (t) => OrderingTerm.asc(t.id)]);
    return q.watch().map((rows) => [
          for (final r in rows)
            DiaryEntry(
              id: r.id,
              dayKey: r.dayKey,
              meal: MealType.tryParse(r.mealType) ?? MealType.snack,
              title: r.title,
              recipeKey: r.recipeKey,
              portionLabel: r.portionLabel,
              macros: Macros(kcal: r.kcal, protein: r.protein, fat: r.fat, carbs: r.carbs),
              createdAt: r.createdAt,
            ),
        ]);
  }

  @override
  Future<void> addEntry(DiaryEntry e) async {
    await db.into(db.loggedMeals).insert(
          LoggedMealsCompanion.insert(
            dayKey: e.dayKey,
            mealType: e.meal.name,
            recipeKey: Value(e.recipeKey),
            title: e.title,
            portionLabel: Value(e.portionLabel),
            kcal: e.macros.kcal,
            protein: e.macros.protein,
            fat: e.macros.fat,
            carbs: e.macros.carbs,
          ),
        );
  }

  @override
  Future<void> deleteEntry(int id) async {
    await (db.delete(db.loggedMeals)..where((t) => t.id.equals(id))).go();
  }
}
