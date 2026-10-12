import 'package:flutter/material.dart';

import 'package:food_ration/foods/custom_foods.dart';
import 'package:food_ration/nutrition/nutrition_controller.dart';
import 'package:food_ration/ui/app_scope.dart';
import 'package:food_ration/ui/custom_food_page.dart';
import 'package:food_ration/ui/dish_composer_page.dart';
import 'package:food_ration/ui/recipe_detail_page.dart';
import 'package:food_ration/ui/recipe_image.dart';

/// Меню «своё»: блюдо из ингредиентов, свой продукт, быстрая запись калорий.
Future<void> showOwnFoodSheet(
  BuildContext context,
  NutritionController controller, {
  VoidCallback? onQuickEntry,
}) {
  final foods = AppScope.foodsOf(context)!;
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheet) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            key: const Key('own-dish'),
            leading: const Icon(Icons.blender_outlined),
            title: const Text('Блюдо из ингредиентов'),
            subtitle: const Text('Указать продукты и вес — калории посчитаются'),
            onTap: () {
              Navigator.pop(sheet);
              DishComposerPage.open(context, controller, foods);
            },
          ),
          ListTile(
            key: const Key('own-product'),
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Свой продукт или полуфабрикат'),
            subtitle: const Text('КБЖУ с этикетки, вес, фото'),
            onTap: () {
              Navigator.pop(sheet);
              _MyFoodsPage.open(context, controller, foods);
            },
          ),
          if (onQuickEntry != null)
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Только калории'),
              subtitle: const Text('Если КБЖУ уже известно'),
              onTap: () {
                Navigator.pop(sheet);
                onQuickEntry();
              },
            ),
        ],
      ),
    ),
  );
}

/// Список своих продуктов и блюд: выбрать, чтобы отметить съеденное, или создать новый.
class _MyFoodsPage extends StatelessWidget {
  const _MyFoodsPage({required this.controller, required this.foods});

  final NutritionController controller;
  final CustomFoodsController foods;

  static Future<void> open(BuildContext context, NutritionController controller, CustomFoodsController foods) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => _MyFoodsPage(controller: controller, foods: foods)),
      );

  Future<void> _create(BuildContext context) async {
    final created = await CustomFoodPage.open(context, foods);
    if (created == null || !context.mounted) return;
    // Каталог обновляется через поток из базы — дожидаемся появления рецепта.
    final key = CustomFood.keyFor(created.id!);
    var recipe = foods.catalog.byKey(key);
    for (var i = 0; recipe == null && i < 20; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      recipe = foods.catalog.byKey(key);
    }
    if (recipe != null && context.mounted) {
      await RecipeDetailPage.open(context, controller, recipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мои продукты и блюда')),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('new-product'),
        onPressed: () => _create(context),
        icon: const Icon(Icons.add),
        label: const Text('Новый продукт'),
      ),
      body: ListenableBuilder(
        listenable: foods,
        builder: (context, _) {
          final list = foods.foods;
          if (list.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Здесь будут ваши полуфабрикаты и блюда. Добавьте продукт: '
                'название, вес упаковки, КБЖУ с этикетки и фото.',
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
            children: [
              for (final f in list)
                Builder(builder: (context) {
                  final r = foods.catalog.byKey(CustomFood.keyFor(f.id!)) ?? f.toRecipe();
                  return RecipeListCard(
                    recipe: r,
                    badge: f.kind == CustomFoodKind.dish ? 'Моё блюдо' : 'Мой продукт',
                    subtitle: '${r.portionLabel(r.defaultPortion)} · ${f.per100.kcal.round()} ккал/100 г',
                    macros: r.defaultPortionMacros,
                    onTap: () => RecipeDetailPage.open(context, controller, r),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}

/// Редактирование своего продукта или блюда по рецепту каталога.
Future<void> editCustomRecipe(
  BuildContext context,
  NutritionController controller,
  int customId,
) async {
  final foods = AppScope.foodsOf(context)!;
  final food = foods.byId(customId);
  if (food == null) return;
  if (food.kind == CustomFoodKind.dish) {
    await DishComposerPage.open(context, controller, foods, dish: food);
  } else {
    await CustomFoodPage.open(context, foods, food: food);
  }
}
