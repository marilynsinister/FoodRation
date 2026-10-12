import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:food_ration/database/app_database.dart';
import 'package:food_ration/nutrition/ingredient.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/nutrition/recipe_catalog.dart';
import 'package:food_ration/planner/drift_planner_repository.dart';
import 'package:food_ration/planner/planner_controller.dart';
import 'package:food_ration/planner/planner_repository.dart';
import 'package:food_ration/settings/settings_controller.dart';

Recipe _recipe(
  String key,
  List<String> ingredients, {
  int servings = 1,
  List<MealType> meals = const [MealType.breakfast],
}) =>
    Recipe(
      key: key,
      name: 'Блюдо $key',
      book: 'Тест',
      category: 'Тест',
      mealTypes: meals,
      ingredients: ingredients,
      steps: const [],
      serving: const Macros(kcal: 300, protein: 20, fat: 10, carbs: 30),
      servings: servings,
    );

final _day = DateTime(2026, 10, 12);

Future<PlannerController> _planner(List<Recipe> recipes) async {
  final c = PlannerController(
    repository: InMemoryPlannerRepository(),
    catalog: RecipeCatalog(recipes),
    clock: () => DateTime(2026, 10, 12, 8),
  );
  await c.init();
  return c;
}

Future<void> _settle() => pumpEventQueue();

void main() {
  group('разбор ингредиентов', () {
    test('количество и единицы в разных записях', () {
      final cases = {
        'Творог 5% - 150 гр': ('творог', 150.0, QtyUnit.g),
        'Яйца, 2 шт': ('яйца', 2.0, QtyUnit.pcs),
        '190 г молока 1,5%': ('молока', 190.0, QtyUnit.g),
        'Кефир, 1%, 120 мл': ('кефир', 120.0, QtyUnit.ml),
        'Разрыхлитель - 1/2 ч.л': ('разрыхлитель', 0.5, QtyUnit.tsp),
        'Псиллиум (или отруби) - 3 ст. л': ('псиллиум', 3.0, QtyUnit.tbsp),
        'Мука - 0,5 кг': ('мука', 500.0, QtyUnit.g),
        'Вода (для варки 1 л.) - 100 мл': ('вода', 100.0, QtyUnit.ml),
        'Куриное филе, 160': ('куриное филе', 160.0, QtyUnit.g),
        'молоко, 2,5%, 70': ('молоко', 70.0, QtyUnit.g),
        '2 яйца': ('яйца', 2.0, QtyUnit.pcs),
        'Чеснок - 2 зубчика': ('чеснок', 2.0, QtyUnit.pcs),
        'Кинза рубленая - 1 столовая ложка': ('кинза рубленая', 1.0, QtyUnit.tbsp),
      };
      cases.forEach((raw, expected) {
        final i = Ingredient.parse(raw);
        expect(i.name, expected.$1, reason: raw);
        expect(i.amount, closeTo(expected.$2, 1e-9), reason: raw);
        expect(i.unit, expected.$3, reason: raw);
      });
      expect(Ingredient.parse('Соль - по вкусу').tracked, isFalse);
      expect(Ingredient.parse('Яйца - 2 шт. (110 г)').altGrams, 110);
    });

    test('пересчёт строки на другое число порций', () {
      expect(Ingredient.parse('Творог 5% - 150 гр').scaled(2), 'Творог 5% - 300 гр');
      expect(Ingredient.parse('Яйца, 1 шт').scaled(1.5), 'Яйца, 1,5 шт');
      expect(Ingredient.parse('Мука - 0,5 кг').scaled(3), 'Мука - 1,5 кг');
      expect(Ingredient.parse('Соль по вкусу').scaled(2), 'Соль по вкусу');
    });

    test('сопоставление названий с учётом окончаний', () {
      bool covers(String pantry, String ingredient) => Ingredient.nameCovers(
            Ingredient.nameTokens(pantry),
            Ingredient.parse(ingredient).tokens,
          );
      expect(covers('Творог', 'Мягкий творог 5% - 340 г'), isTrue);
      expect(covers('Яйца', 'Яйцо - 1 шт'), isTrue);
      expect(covers('Сливочное масло', 'Масло подсолнечное – 80 гр'), isFalse);
    });

    test('все рецепты каталога разбираются', () {
      final catalog = RecipeCatalog.fromJsonString(File(RecipeCatalog.assetPath).readAsStringSync());
      var tracked = 0;
      var total = 0;
      for (final r in catalog.recipes) {
        for (final i in r.parsedIngredients) {
          total++;
          if (i.tracked) tracked++;
          i.scaled(2);
        }
        expect(r.yieldServings, greaterThan(0), reason: r.name);
      }
      // Большинство строк содержат количество.
      expect(tracked / total, greaterThan(0.8));
    });
  });

  test('ингредиенты пересчитываются на порции рецепта', () {
    final r = _recipe('a', ['Творог - 300 гр'], servings: 2);
    expect(r.ingredientScale(1), 0.5);
    expect(r.ingredientScale(4), 2);
  });

  group('план и запасы', () {
    test('остаток творога переходит на следующие приёмы пищи', () async {
      final breakfast = _recipe('b', ['Творог 5% - 100 гр', 'Яйца - 1 шт']);
      final dinner = _recipe('d', ['Творог - 200 гр'], meals: [MealType.dinner]);
      final c = await _planner([breakfast, dinner]);
      await c.addToPantry('Творог', 500, PantryUnit.g);
      await c.addToPlan(breakfast, _day, MealType.breakfast);
      await c.addToPlan(dinner, _day, MealType.dinner, servings: 2);
      await _settle();

      final cottage = c.pantry.single;
      expect(c.projection.planned[cottage.id], 500);
      expect(c.projection.remaining[cottage.id], 0);

      // 100 г на завтрак + 400 г на две порции ужина — творога ровно хватает,
      // ещё одна порция ужина уже потребует докупки.
      await c.addToPlan(dinner, DateTime(2026, 10, 13), MealType.dinner);
      await _settle();
      final shopping = {for (final s in c.projection.shopping) s.name: s};
      expect(shopping['Творог']!.amount, 200);
      expect(shopping['яйца']!.amount, 1);
      expect(shopping['яйца']!.unit, PantryUnit.pcs);

      // Покупка из списка пополняет существующий продукт.
      await c.buy(shopping['Творог']!);
      await _settle();
      expect(c.pantry.single.amount, 700);
      expect(c.projection.shopping.map((s) => s.name), ['яйца']);
    });

    test('приготовленное блюдо списывается из запасов', () async {
      final r = _recipe('b', ['Творог - 150 гр', 'Яйца - 1 шт']);
      final c = await _planner([r]);
      await c.addToPantry('Творог', 500, PantryUnit.g);
      await c.addToPantry('Яйца', 1, PantryUnit.pcs);
      await c.addToPlan(r, _day, MealType.breakfast, servings: 1);
      await _settle();
      await c.markCooked(c.plan.single);
      await _settle();
      expect(c.pantry.single.name, 'Творог');
      expect(c.pantry.single.amount, 350);
      expect(c.plan.single.done, isTrue);
      expect(c.projection.entries, isEmpty);
    });

    test('подбор рецептов по остаткам продуктов', () async {
      final withCottage = _recipe('c', ['Творог - 150 гр', 'Мука - 30 гр']);
      final withoutCottage = _recipe('o', ['Овсянка - 50 гр']);
      final c = await _planner([withoutCottage, withCottage]);
      await c.addToPantry('Творог', 400, PantryUnit.g);
      await _settle();
      final list = c.suggestFromPantry(MealType.breakfast);
      expect(list.first.recipe.key, 'c');
      expect(list.first.used.values.single, 150);
      expect(list.first.missing, 1);
    });

    test('Drift: план и запасы сохраняются', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final repo = DriftPlannerRepository(db);
      await repo.savePantryItem(PantryItem(name: 'Творог', amount: 500, unit: PantryUnit.g));
      await repo.addPlanEntry(const PlanEntry(
        dayKey: '2026-10-12',
        meal: MealType.breakfast,
        recipeKey: 'x',
        servings: 2,
      ));
      final plan = await repo.watchPlan().first;
      expect(plan.single.servings, 2);
      await repo.updatePlanEntry(plan.single.copyWith(done: true));
      expect((await repo.watchPlan().first).single.done, isTrue);
      final pantry = await repo.watchPantry().first;
      expect(pantry.single.unit, PantryUnit.g);

      final store = DriftSettingsStore(db);
      final settings = SettingsController(store);
      await settings.setThemeMode(ThemeMode.dark);
      await settings.setDarkVariant(DarkVariant.amoled);
      final again = SettingsController(store);
      await again.init();
      expect(again.themeMode, ThemeMode.dark);
      expect(again.darkVariant, DarkVariant.amoled);
      expect(again.darkTheme.colorScheme.surface, Colors.black);
    });
  });
}
