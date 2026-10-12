import 'package:flutter/material.dart';

import 'package:food_ration/database/app_database.dart';

/// Вариант тёмной темы.
enum DarkVariant {
  graphite('Графит', 'Мягкий тёмно-серый, стандарт Material'),
  amoled('Чёрная AMOLED', 'Чистый чёрный фон, бережёт батарею'),
  cocoa('Какао', 'Тёплые коричневые тона, мягче для глаз вечером');

  const DarkVariant(this.label, this.description);

  final String label;
  final String description;
}

/// Акцентный цвет приложения.
enum AccentColor {
  teal('Бирюза', Colors.teal),
  green('Зелень', Color(0xFF4C8C4A)),
  indigo('Индиго', Colors.indigo),
  orange('Апельсин', Color(0xFFE07A2E)),
  rose('Роза', Color(0xFFC2185B));

  const AccentColor(this.label, this.color);

  final String label;
  final Color color;
}

abstract class SettingsStore {
  Future<Map<String, String>> loadAll();

  Future<void> put(String key, String value);
}

class InMemorySettingsStore implements SettingsStore {
  final _values = <String, String>{};

  @override
  Future<Map<String, String>> loadAll() async => Map.of(_values);

  @override
  Future<void> put(String key, String value) async => _values[key] = value;
}

class DriftSettingsStore implements SettingsStore {
  DriftSettingsStore(this.db);

  final AppDatabase db;

  @override
  Future<Map<String, String>> loadAll() async => {
        for (final r in await db.select(db.settingsEntries).get()) r.key: r.value,
      };

  @override
  Future<void> put(String key, String value) => db
      .into(db.settingsEntries)
      .insertOnConflictUpdate(SettingsEntriesCompanion.insert(key: key, value: value));
}

/// Настройки оформления: режим темы, вариант тёмной темы, акцент.
class SettingsController extends ChangeNotifier {
  SettingsController(this.store);

  final SettingsStore store;

  ThemeMode _themeMode = ThemeMode.system;
  DarkVariant _darkVariant = DarkVariant.graphite;
  AccentColor _accent = AccentColor.teal;

  ThemeMode get themeMode => _themeMode;

  DarkVariant get darkVariant => _darkVariant;

  AccentColor get accent => _accent;

  Future<void> init() async {
    final v = await store.loadAll();
    T byName<T extends Enum>(List<T> values, String? code, T fallback) =>
        values.firstWhere((e) => e.name == code, orElse: () => fallback);
    _themeMode = byName(ThemeMode.values, v['themeMode'], ThemeMode.system);
    _darkVariant = byName(DarkVariant.values, v['darkVariant'], DarkVariant.graphite);
    _accent = byName(AccentColor.values, v['accent'], AccentColor.teal);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode m) => _set('themeMode', m, () => _themeMode = m);

  Future<void> setDarkVariant(DarkVariant d) => _set('darkVariant', d, () => _darkVariant = d);

  Future<void> setAccent(AccentColor a) => _set('accent', a, () => _accent = a);

  Future<void> _set(String key, Enum value, VoidCallback apply) async {
    apply();
    notifyListeners();
    await store.put(key, value.name);
  }

  ThemeData get lightTheme => buildLightTheme(_accent);

  ThemeData get darkTheme => buildDarkTheme(_accent, _darkVariant);
}

ThemeData buildLightTheme(AccentColor accent) => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: accent.color),
      useMaterial3: true,
    );

ThemeData buildDarkTheme(AccentColor accent, DarkVariant variant) {
  final base = ColorScheme.fromSeed(seedColor: accent.color, brightness: Brightness.dark);
  final scheme = switch (variant) {
    DarkVariant.graphite => base,
    DarkVariant.amoled => base.copyWith(
        surface: Colors.black,
        surfaceDim: Colors.black,
        surfaceContainerLowest: Colors.black,
        surfaceContainerLow: const Color(0xFF0B0B0B),
        surfaceContainer: const Color(0xFF121212),
        surfaceContainerHigh: const Color(0xFF1A1A1A),
        surfaceContainerHighest: const Color(0xFF232323),
        surfaceBright: const Color(0xFF2A2A2A),
      ),
    DarkVariant.cocoa => base.copyWith(
        surface: const Color(0xFF1C1612),
        surfaceDim: const Color(0xFF16110E),
        surfaceContainerLowest: const Color(0xFF130F0C),
        surfaceContainerLow: const Color(0xFF241D18),
        surfaceContainer: const Color(0xFF2A221C),
        surfaceContainerHigh: const Color(0xFF342A23),
        surfaceContainerHighest: const Color(0xFF3F332B),
        surfaceBright: const Color(0xFF453830),
        onSurface: const Color(0xFFEDE0D4),
        onSurfaceVariant: const Color(0xFFD6C3B3),
        outline: const Color(0xFF9F8D7F),
        outlineVariant: const Color(0xFF51443A),
      ),
  };
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: scheme.surface,
  );
}
