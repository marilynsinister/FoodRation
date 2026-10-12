import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:food_ration/app.dart';
import 'package:food_ration/database/app_database.dart' hide ActivityLevel;
import 'package:food_ration/foods/custom_foods.dart';
import 'package:food_ration/foods/food_reference.dart';
import 'package:food_ration/nutrition/kbju_calculator.dart';
import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/nutrition/nutrition_repository.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/nutrition/recipe_catalog.dart';
import 'package:food_ration/planner/planner_controller.dart';
import 'package:food_ration/planner/planner_repository.dart';
import 'package:food_ration/settings/settings_controller.dart';

RecipeCatalog _loadCatalog() =>
    RecipeCatalog.fromJsonString(File(RecipeCatalog.assetPath).readAsStringSync());

const _dumplings = CustomFood(
  kind: CustomFoodKind.product,
  name: 'Пельмени Сибирские',
  per100: Macros(kcal: 250, protein: 12, fat: 12, carbs: 24),
  portionG: 250,
);

void main() {
  test('у всех рецептов известен вес порции', () {
    final catalog = _loadCatalog();
    final missing = [
      for (final r in catalog.recipes)
        if (r.servingWeightG == null || r.servingWeightG! <= 0) r.name,
    ];
    expect(missing, isEmpty);
    final r = catalog.recipes.firstWhere((r) => r.serving != null && r.servingWeightApprox);
    expect(r.portionLabel(const Portion.servings(1)), contains('≈'));
    expect(r.servingsLabel(2), contains(' г'));
  });

  test('блюдо из ингредиентов: КБЖУ на 100 г с учётом уварки', () {
    const cottage = FoodPart(name: 'Творог 5%', grams: 200, per100: Macros(kcal: 121, protein: 17.2, fat: 5, carbs: 1.8));
    const egg = FoodPart(name: 'Яйцо', grams: 55, per100: Macros(kcal: 157, protein: 12.7, fat: 11.5, carbs: 0.7));
    final raw = CustomFood.per100Of([cottage, egg], null);
    expect(raw.kcal, closeTo((242 + 86.35) / 255 * 100, 0.01));
    final cooked = CustomFood.per100Of([cottage, egg], 200);
    expect(cooked.kcal, closeTo((242 + 86.35) / 200 * 100, 0.01));
    expect(searchFoods('творог 5', foodReference).first.name, 'Творог 5%');
  });

  test('свой продукт работает в каталоге, плане и покупках', () async {
    final catalog = _loadCatalog();
    final foods = CustomFoodsController(repository: InMemoryCustomFoodRepository(), catalog: catalog);
    await foods.init();
    final planner = PlannerController(
      repository: InMemoryPlannerRepository(),
      catalog: catalog,
      clock: () => DateTime(2026, 10, 12, 8),
    );
    await planner.init();
    final id = await foods.save(_dumplings);
    await pumpEventQueue();

    final r = catalog.byKey(CustomFood.keyFor(id))!;
    expect(catalog.recipes.first, same(r));
    expect(r.macrosFor(const Portion.grams(250)).kcal, 625);
    expect(r.servingsLabel(1), contains('250 г'));

    // Куплена одна пачка 900 г, в плане 2 порции на ужин + 2 завтра.
    await planner.addToPantry('Пельмени', 900, PantryUnit.g);
    await planner.addToPlan(r, DateTime(2026, 10, 12), MealType.dinner, servings: 2);
    await planner.addToPlan(r, DateTime(2026, 10, 13), MealType.dinner, servings: 2);
    await pumpEventQueue();
    expect(planner.projection.planned.values.single, 900);
    expect(planner.projection.shopping.single.amount, 100);
  });

  test('Drift: свои продукты с фото сохраняются', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = DriftCustomFoodRepository(db);
    final photo = Uint8List.fromList([1, 2, 3]);
    final id = await repo.save(CustomFood(
      kind: CustomFoodKind.dish,
      name: 'Омлет',
      per100: const Macros(kcal: 150, protein: 10, fat: 10, carbs: 2),
      parts: const [FoodPart(name: 'Яйцо', grams: 110, per100: Macros(kcal: 157, protein: 12.7, fat: 11.5, carbs: 0.7))],
      mealTypes: const [MealType.breakfast],
      photo: photo,
    ));
    final f = (await repo.watchAll().first).single;
    expect(f.id, id);
    expect(f.kind, CustomFoodKind.dish);
    expect(f.parts.single.grams, 110);
    expect(f.mealTypes, [MealType.breakfast]);
    expect(f.photo, photo);
    expect(f.toRecipe().ingredients.single, 'Яйцо - 110 г');
  });

  group('приложение', () {
    late NutritionController controller;
    late Widget app;

    Future<void> pumpApp(WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 6000);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.reset);
      final catalog = _loadCatalog();
      controller = NutritionController(
        repository: InMemoryNutritionRepository(),
        catalog: catalog,
        clock: () => DateTime(2026, 10, 12, 9),
      );
      final planner = PlannerController(repository: InMemoryPlannerRepository(), catalog: catalog);
      final foods = CustomFoodsController(repository: InMemoryCustomFoodRepository(), catalog: catalog);
      await controller.init();
      await planner.init();
      await foods.init();
      await controller.saveProfile(NutritionProfile.initial);
      app = FoodRationApp(
        controller: controller,
        planner: planner,
        settings: SettingsController(InMemorySettingsStore()),
        foods: foods,
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
    }

    String title(WidgetTester tester) =>
        (tester.widget<AppBar>(find.byType(AppBar).first).title as Text).data!;

    /// Системная кнопка «Назад»; true — приложение обработало её само.
    Future<bool> back(WidgetTester tester) async {
      final handled = await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      return handled;
    }

    testWidgets('«Назад» возвращает на предыдущие экраны', (tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Рецепты'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('План'));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Продукты ('));
      await tester.pumpAndSettle();

      // Открытая страница закрывается первой.
      await tester.tap(find.byKey(const Key('open-settings')));
      await tester.pumpAndSettle();
      expect(find.text('Настройки'), findsOneWidget);
      expect(await back(tester), isTrue);
      expect(find.text('Настройки'), findsNothing);

      // Подвкладка плана → «Меню», затем предыдущая вкладка, затем «Сегодня».
      expect(await back(tester), isTrue);
      expect(title(tester), 'План');
      expect(find.text('Сегодня — Вс 18.10'), findsOneWidget);
      expect(await back(tester), isTrue);
      expect(title(tester), 'Рецепты');
      expect(await back(tester), isTrue);
      expect(title(tester), 'Сегодня');
      // С «Сегодня» — системе (приложение сворачивается).
      expect(await back(tester), isFalse);
    });

    testWidgets('своё блюдо из ингредиентов записывается в дневник', (tester) async {
      await pumpApp(tester);
      await tester.ensureVisible(find.byKey(const Key('add-own')));
      await tester.tap(find.byKey(const Key('add-own')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('own-dish')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('dish-name')), 'Творожная запеканка');
      await tester.tap(find.byKey(const Key('dish-add-part')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('food-search')), 'творог 5');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Творог 5%'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('part-grams')), '400');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('part-done')));
      await tester.pumpAndSettle();

      // 400 г творога = 484 ккал; съели 100 г из 400.
      await tester.enterText(find.byKey(const Key('dish-eaten')), '100');
      await tester.pumpAndSettle();
      expect(find.text('Съедено 100 г'), findsOneWidget);
      await tester.ensureVisible(find.byKey(const Key('dish-log')));
      await tester.tap(find.byKey(const Key('dish-log')));
      await tester.pumpAndSettle();

      final e = controller.entries.single;
      expect(e.title, 'Творожная запеканка');
      expect(e.portionLabel, '100 г');
      expect(e.macros.kcal, closeTo(121, 0.01));
    });
  });
}
