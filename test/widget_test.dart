import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:food_ration/app.dart';
import 'package:food_ration/database/app_database.dart' hide ActivityLevel;
import 'package:food_ration/nutrition/drift_nutrition_repository.dart';
import 'package:food_ration/nutrition/kbju_calculator.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/nutrition_repository.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/nutrition/recipe_catalog.dart';
import 'package:food_ration/nutrition/recommender.dart';
import 'package:food_ration/ui/today_tab.dart';

RecipeCatalog _loadCatalog() =>
    RecipeCatalog.fromJsonString(File(RecipeCatalog.assetPath).readAsStringSync());

const _profile = NutritionProfile(
  sex: Sex.female,
  age: 30,
  heightCm: 165,
  weightKg: 65,
  activity: ActivityLevel.light,
  goal: Goal.loseWeight,
);

void main() {
  group('calculateKbju', () {
    test('Миффлин — Сан Жеор и поправка под цель', () {
      final r = calculateKbju(_profile);
      // 9.99*65 + 6.25*165 - 4.92*30 - 161
      expect(r.bmr, closeTo(1372.0, 0.1));
      expect(r.tdee, closeTo(1372.0 * 1.35, 0.1));
      expect(r.target.kcal, (r.tdee * 0.85).roundToDouble());
      expect(r.target.protein, (1.8 * 65).roundToDouble());

      final kcalByGoal = {
        for (final g in Goal.values) g: calculateKbju(_profile.copyWith(goal: g)).target.kcal,
      };
      expect(kcalByGoal[Goal.loseWeight]! < kcalByGoal[Goal.maintain]!, isTrue);
      expect(kcalByGoal[Goal.maintain]! < kcalByGoal[Goal.gainMuscle]!, isTrue);
      expect(kcalByGoal[Goal.gainMuscle]! < kcalByGoal[Goal.gainMass]!, isTrue);
    });

    test('дефицит не опускается ниже базового обмена', () {
      final r = calculateKbju(_profile.copyWith(activity: ActivityLevel.sedentary));
      expect(r.target.kcal >= r.bmr.roundToDouble(), isTrue);
    });
  });

  group('каталог и подбор', () {
    final catalog = _loadCatalog();
    final recommender = Recommender(catalog.recipes);
    final target = calculateKbju(_profile).target;

    test('каталог содержит рецепты из всех сборников с КБЖУ', () {
      expect(catalog.recipes.length, greaterThan(800));
      expect(catalog.books, containsAll(['Классический', 'Постный', 'Праздничный', 'Любимые завтраки']));
      for (final r in catalog.recipes) {
        expect(r.defaultPortionMacros.kcal, greaterThan(0), reason: r.name);
      }
    });

    test('план на день укладывается в норму калорий', () {
      final day = DayContext(target: target, eaten: Macros.zero, loggedMeals: {});
      final plan = recommender.planRestOfDay(day);
      expect(plan.map((p) => p.meal), MealType.values);
      final total = plan.fold(Macros.zero, (Macros s, p) => s + p.suggestion.macros);
      expect(total.kcal, lessThanOrEqualTo(target.kcal + 30));
      expect(total.kcal, greaterThan(target.kcal * 0.8));
    });

    test('после съеденного предлагаются только блюда, влезающие в остаток', () {
      final eaten = target * 0.8;
      final day = DayContext(target: target, eaten: eaten, loggedMeals: {MealType.breakfast, MealType.lunch});
      final list = recommender.suggest(day, MealType.dinner, limit: 50);
      expect(list, isNotEmpty);
      for (final s in list) {
        expect(s.macros.kcal, lessThanOrEqualTo(day.remaining.kcal + 25), reason: s.recipe.name);
        expect(s.recipe.mealTypes, contains(MealType.dinner));
      }
    });

    test('при нехватке белка в остатке наверху белковые блюда', () {
      final eaten = Macros(kcal: target.kcal * 0.5, protein: 10, fat: target.fat * 0.6, carbs: target.carbs * 0.8);
      final day = DayContext(target: target, eaten: eaten, loggedMeals: {MealType.breakfast, MealType.lunch});
      final top = recommender.suggest(day, MealType.dinner, limit: 5);
      for (final s in top) {
        expect(s.macros.protein * kcalPerGramProtein / s.macros.kcal, greaterThan(0.3), reason: s.recipe.name);
      }
    });
  });

  test('Drift: профиль и дневник сохраняются', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = DriftNutritionRepository(db);
    await repo.saveProfile(_profile.copyWith(goal: Goal.gainMuscle, customKcal: () => 2100));
    final p = await repo.loadProfile();
    expect(p!.goal, Goal.gainMuscle);
    expect(p.customKcal, 2100);

    await repo.addEntry(const DiaryEntry(
      dayKey: '2026-10-11',
      meal: MealType.lunch,
      title: 'Борщ',
      macros: Macros(kcal: 300, protein: 20, fat: 10, carbs: 30),
    ));
    final rows = await repo.watchDay('2026-10-11').first;
    expect(rows.single.title, 'Борщ');
    expect(await repo.watchDay('2026-10-12').first, isEmpty);
  });

  testWidgets('расчёт нормы, отметка рецепта и обновление остатка', (tester) async {
    tester.view.physicalSize = const Size(1080, 6000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);

    final controller = NutritionController(
      repository: InMemoryNutritionRepository(),
      catalog: _loadCatalog(),
      clock: () => DateTime(2026, 10, 11, 9),
    );
    await controller.init();
    await tester.pumpWidget(FoodRationApp(controller: controller));
    await tester.pumpAndSettle();

    // Без профиля открывается калькулятор.
    expect(find.text('Калькулятор КБЖУ'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('save-profile')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('save-profile')));
    await tester.pumpAndSettle();

    final target = calculateKbju(NutritionProfile.initial).target;
    expect(find.text('Осталось ${target.kcal.round()} ккал'), findsOneWidget);
    expect(find.text('План на остаток дня'), findsOneWidget);

    // Открываем первое предложение на завтрак и отмечаем его.
    await tester.ensureVisible(find.byType(SuggestionTile).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SuggestionTile).first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('log-recipe')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('log-recipe')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('kcal-left')));
    await tester.pumpAndSettle();

    expect(controller.entries, hasLength(1));
    final left = target.kcal - controller.entries.single.macros.kcal;
    expect(find.text('Осталось ${left.round()} ккал'), findsOneWidget);
    expect(find.text('Съедено сегодня'), findsOneWidget);
  });
}
