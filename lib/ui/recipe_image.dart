import 'package:flutter/material.dart';

import 'package:food_ration/nutrition/macros.dart';
import 'package:food_ration/nutrition/recipe.dart';
import 'package:food_ration/ui/charts.dart';
import 'package:food_ration/ui/macro_widgets.dart';

/// Фото блюда из сборника; если фото нет — цветная заглушка по категории.
class RecipeImage extends StatelessWidget {
  const RecipeImage({
    super.key,
    required this.recipe,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.cacheWidth,
  });

  final Recipe recipe;
  final double? width;
  final double? height;
  final double borderRadius;

  /// Ширина декодирования в пикселях — для миниатюр в списках.
  final int? cacheWidth;

  static const _categoryIcons = {
    'Супы': Icons.soup_kitchen,
    'Салаты': Icons.eco,
    'Закуски': Icons.tapas,
    'Вторые блюда': Icons.dinner_dining,
    'Торты': Icons.cake,
    'Выпечка и десерты': Icons.bakery_dining,
    'Соусы и кремы': Icons.water_drop,
    'Завтраки': Icons.free_breakfast,
    'Из рациона': Icons.restaurant,
    'Напитки': Icons.local_cafe,
  };

  static const categoryCovers = {
    'Супы': 'assets/recipe_images/cat_soups.png',
    'Салаты': 'assets/recipe_images/cat_salads.png',
    'Закуски': 'assets/recipe_images/cat_snacks.png',
    'Вторые блюда': 'assets/recipe_images/cat_mains.png',
    'Торты': 'assets/recipe_images/cat_cakes.png',
    'Выпечка и десерты': 'assets/recipe_images/cat_dessert.png',
    'Соусы и кремы': 'assets/recipe_images/cat_sauces.png',
    'Завтраки': 'assets/recipe_images/cat_breakfast.png',
    'Из рациона': 'assets/recipe_images/cat_ration.png',
    'Напитки': 'assets/recipe_images/cat_drinks.png',
    'Разное': 'assets/recipe_images/cat_other.png',
  };

  @override
  Widget build(BuildContext context) {
    final placeholder = _Placeholder(
      icon: _categoryIcons[recipe.category] ?? Icons.restaurant,
      seed: recipe.category.hashCode,
    );
    Widget asset(String path, Widget fallback) => Image.asset(
          path,
          fit: BoxFit.cover,
          width: width,
          height: height,
          cacheWidth: cacheWidth,
          errorBuilder: (_, _, _) => fallback,
        );
    final cover = categoryCovers[recipe.category];
    final fallback = cover == null ? placeholder : asset(cover, placeholder);
    final image = recipe.image == null ? fallback : asset(recipe.image!, fallback);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(width: width, height: height, child: image),
    );
  }
}

/// Карточка рецепта для списков: фото, название, подпись, КБЖУ и полоска БЖУ.
class RecipeListCard extends StatelessWidget {
  const RecipeListCard({
    super.key,
    required this.recipe,
    required this.subtitle,
    required this.macros,
    this.badge,
    this.onTap,
    this.trailing,
  });

  final Recipe recipe;
  final String subtitle;
  final Macros macros;
  final String? badge;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              RecipeImage(
                recipe: recipe,
                width: 76,
                height: 76,
                borderRadius: 10,
                cacheWidth: (76 * dpr).round(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (badge != null)
                      Text(
                        badge!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    Text(
                      recipe.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: MacroLine(macros, style: theme.textTheme.bodySmall),
                      ),
                    ),
                    const SizedBox(height: 4),
                    MacroSplitBar(macros: macros),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.icon, required this.seed});

  final IconData icon;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final hue = (seed % 360).abs().toDouble();
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HSLColor.fromAHSL(1, hue, 0.45, 0.80).toColor(),
            HSLColor.fromAHSL(1, (hue + 40) % 360, 0.45, 0.65).toColor(),
          ],
        ),
      ),
      child: Center(child: Icon(icon, color: Colors.white, size: 28)),
    );
  }
}
