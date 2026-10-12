import 'dart:async';

import 'package:flutter/foundation.dart';

import 'kbju_calculator.dart';
import 'macros.dart';
import 'nutrition_repository.dart';
import 'recipe.dart';
import 'recipe_catalog.dart';
import 'recommender.dart';

/// Состояние экрана «Сегодня»: профиль, норма, записи дня и подбор блюд.
class NutritionController extends ChangeNotifier {
  NutritionController({
    required this.repository,
    required this.catalog,
    DateTime Function()? clock,
  })  : _clock = clock ?? DateTime.now,
        recommender = Recommender(catalog.bookRecipes) {
    // Свои продукты появляются в каталоге — экраны должны перестроиться.
    catalog.addListener(notifyListeners);
  }

  final NutritionRepository repository;
  final RecipeCatalog catalog;
  final Recommender recommender;
  final DateTime Function() _clock;

  NutritionProfile? _profile;
  List<DiaryEntry> _entries = const [];
  StreamSubscription<List<DiaryEntry>>? _sub;
  String? _dayKey;
  bool _loaded = false;

  bool get loaded => _loaded;

  NutritionProfile? get profile => _profile;

  bool get hasProfile => _profile != null;

  KbjuResult? get kbju => _profile == null ? null : calculateKbju(_profile!);

  List<DiaryEntry> get entries => _entries;

  String get dayKey => _dayKey ?? dayKeyOf(_clock());

  Macros get eaten => _entries.fold(Macros.zero, (s, e) => s + e.macros);

  DayContext? get day {
    final k = kbju;
    if (k == null) return null;
    return DayContext(
      target: k.target,
      eaten: eaten,
      loggedMeals: {for (final e in _entries) e.meal},
      eatenRecipeKeys: {
        for (final e in _entries)
          if (e.recipeKey != null) e.recipeKey!,
      },
    );
  }

  Future<void> init() async {
    _profile = await repository.loadProfile();
    _loaded = true;
    _watchToday();
    notifyListeners();
  }

  /// Переключает подписку, если наступил новый день.
  void ensureToday() {
    if (_dayKey != dayKeyOf(_clock())) _watchToday();
  }

  void _watchToday() {
    _sub?.cancel();
    _dayKey = dayKeyOf(_clock());
    _entries = const [];
    _sub = repository.watchDay(_dayKey!).listen((rows) {
      _entries = rows;
      notifyListeners();
    });
  }

  Future<void> saveProfile(NutritionProfile p) async {
    await repository.saveProfile(p);
    _profile = p;
    notifyListeners();
  }

  Future<void> logRecipe(Recipe r, Portion portion, MealType meal) async {
    ensureToday();
    await repository.addEntry(DiaryEntry(
      dayKey: dayKey,
      meal: meal,
      title: r.name,
      recipeKey: r.key,
      portionLabel: r.portionLabel(portion),
      macros: r.macrosFor(portion),
    ));
  }

  Future<void> logCustom(String title, Macros macros, MealType meal, {String? portionLabel}) async {
    ensureToday();
    await repository.addEntry(DiaryEntry(
      dayKey: dayKey,
      meal: meal,
      title: title,
      portionLabel: portionLabel,
      macros: macros,
    ));
  }

  Future<void> deleteEntry(DiaryEntry e) async {
    if (e.id != null) await repository.deleteEntry(e.id!);
  }

  /// Приём пищи по умолчанию для новой записи: ближайший неотмеченный
  /// с учётом времени суток.
  MealType defaultMealNow() {
    final h = _clock().hour;
    final byTime = h < 11
        ? MealType.breakfast
        : h < 15
            ? MealType.lunch
            : h < 18
                ? MealType.snack
                : MealType.dinner;
    final logged = {for (final e in _entries) e.meal};
    if (!logged.contains(byTime)) return byTime;
    for (final m in MealType.values) {
      if (m.index > byTime.index && !logged.contains(m)) return m;
    }
    return byTime;
  }

  @override
  void dispose() {
    catalog.removeListener(notifyListeners);
    _sub?.cancel();
    super.dispose();
  }
}
