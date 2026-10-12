import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'recipe.dart';

/// Рецепты из сборников плюс свои продукты и блюда пользователя.
class RecipeCatalog extends ChangeNotifier {
  RecipeCatalog(this.bookRecipes) {
    _rebuild();
  }

  static const assetPath = 'assets/recipes/recipes.json';

  /// Рецепты из assets/recipes/recipes.json.
  final List<Recipe> bookRecipes;
  List<Recipe> _custom = const [];

  late List<Recipe> _all;
  late Map<String, Recipe> _byKey;
  late List<String> _categories;
  late List<String> _books;

  /// Свои продукты и блюда идут первыми.
  List<Recipe> get recipes => _all;

  List<Recipe> get customRecipes => _custom;

  Recipe? byKey(String key) => _byKey[key];

  List<String> get categories => _categories;

  List<String> get books => _books;

  /// Заменяет свои продукты и блюда (при изменении в базе).
  void setCustom(List<Recipe> custom) {
    _custom = custom;
    _rebuild();
    notifyListeners();
  }

  void _rebuild() {
    _all = [..._custom, ...bookRecipes];
    _byKey = {for (final r in _all) r.key: r};
    _categories = {for (final r in _all) r.category}.toList()..sort();
    _books = {for (final r in _all) r.book}.toList()..sort();
  }

  static RecipeCatalog fromJsonString(String source) {
    final data = jsonDecode(source) as Map<String, dynamic>;
    return RecipeCatalog([
      for (final j in data['recipes'] as List) Recipe.fromJson(j as Map<String, dynamic>),
    ]);
  }

  static Future<RecipeCatalog> loadFromAssets() async =>
      fromJsonString(await rootBundle.loadString(assetPath));
}
