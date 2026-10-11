import 'dart:async';

import 'kbju_calculator.dart';
import 'macros.dart';
import 'recipe.dart';

class DiaryEntry {
  const DiaryEntry({
    this.id,
    required this.dayKey,
    required this.meal,
    required this.title,
    required this.macros,
    this.recipeKey,
    this.portionLabel,
    this.createdAt,
  });

  final int? id;
  final String dayKey;
  final MealType meal;
  final String title;
  final Macros macros;
  final String? recipeKey;
  final String? portionLabel;
  final DateTime? createdAt;
}

String dayKeyOf(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

abstract class NutritionRepository {
  Future<NutritionProfile?> loadProfile();

  Future<void> saveProfile(NutritionProfile profile);

  Stream<List<DiaryEntry>> watchDay(String dayKey);

  Future<void> addEntry(DiaryEntry entry);

  Future<void> deleteEntry(int id);
}

/// Хранение в памяти: веб-сборка (Drift там не настроен) и тесты.
class InMemoryNutritionRepository implements NutritionRepository {
  NutritionProfile? _profile;
  final _entries = <DiaryEntry>[];
  final _changes = StreamController<void>.broadcast();
  var _nextId = 1;

  @override
  Future<NutritionProfile?> loadProfile() async => _profile;

  @override
  Future<void> saveProfile(NutritionProfile profile) async => _profile = profile;

  @override
  Stream<List<DiaryEntry>> watchDay(String dayKey) async* {
    List<DiaryEntry> snapshot() => [for (final e in _entries) if (e.dayKey == dayKey) e];
    yield snapshot();
    await for (final _ in _changes.stream) {
      yield snapshot();
    }
  }

  @override
  Future<void> addEntry(DiaryEntry e) async {
    _entries.add(DiaryEntry(
      id: _nextId++,
      dayKey: e.dayKey,
      meal: e.meal,
      title: e.title,
      macros: e.macros,
      recipeKey: e.recipeKey,
      portionLabel: e.portionLabel,
      createdAt: DateTime.now(),
    ));
    _changes.add(null);
  }

  @override
  Future<void> deleteEntry(int id) async {
    _entries.removeWhere((e) => e.id == id);
    _changes.add(null);
  }
}
