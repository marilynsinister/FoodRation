import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// SQLite на устройстве (Android, iOS, desktop).
///
/// - **Windows:** `D:\Android\DB\FoodRation\food_ration.sqlite`
/// - **Android:** `<внешнее хранилище приложения>/DB/FoodRation/food_ration.sqlite`
///   (обычно `Android/data/<id_пакета>/files/DB/FoodRation/` — видно в файловом менеджере и по USB)
/// - **iOS / macOS / Linux:** [getApplicationDocumentsDirectory]
QueryExecutor openDatabaseConnection() {
  return LazyDatabase(() async {
    final Directory dir;
    if (Platform.isWindows) {
      dir = Directory(r'D:\Android\DB\FoodRation');
    } else if (Platform.isAndroid) {
      final external = await getExternalStorageDirectory();
      dir = external != null
          ? Directory(p.join(external.path, 'DB', 'FoodRation'))
          : await getApplicationDocumentsDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final file = File(p.join(dir.path, 'food_ration.sqlite'));
    return NativeDatabase.createInBackground(
      file,
      setup: (db) {
        db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}
