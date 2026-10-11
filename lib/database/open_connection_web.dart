import 'package:drift/drift.dart';

/// Заглушка для веб-сборки: полноценный SQLite через Drift на вебе — отдельная настройка (wasm/sql.js).
QueryExecutor openDatabaseConnection() {
  return LazyDatabase(() async {
    throw UnsupportedError(
      'Локальная Drift/SQLite на этом шаблоне для веба не настроена. '
      'Соберите приложение под Android, iOS или desktop.',
    );
  });
}
