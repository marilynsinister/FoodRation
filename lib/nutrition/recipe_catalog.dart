import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'recipe.dart';

class RecipeCatalog {
  RecipeCatalog(this.recipes) : _byKey = {for (final r in recipes) r.key: r};

  static const assetPath = 'assets/recipes/recipes.json';

  final List<Recipe> recipes;
  final Map<String, Recipe> _byKey;

  Recipe? byKey(String key) => _byKey[key];

  late final List<String> categories = {
    for (final r in recipes) r.category,
  }.toList()
    ..sort();

  late final List<String> books = {
    for (final r in recipes) r.book,
  }.toList()
    ..sort();

  static RecipeCatalog fromJsonString(String source) {
    final data = jsonDecode(source) as Map<String, dynamic>;
    return RecipeCatalog([
      for (final j in data['recipes'] as List) Recipe.fromJson(j as Map<String, dynamic>),
    ]);
  }

  static Future<RecipeCatalog> loadFromAssets() async =>
      fromJsonString(await rootBundle.loadString(assetPath));
}
