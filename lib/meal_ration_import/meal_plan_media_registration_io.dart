import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import 'package:food_ration/database/app_database.dart';

import 'extracted_pdf_page_image.dart';

Future<Map<int, int>> registerExtractedPageImages(
  AppDatabase db, {
  required String absoluteImageDirectory,
  required List<ExtractedPdfPageImage> extracted,
  String? sourceFileId,
}) async {
  final map = <int, int>{};
  for (final e in extracted) {
    final fullPath = p.join(absoluteImageDirectory, e.fileName);
    final bytes = await File(fullPath).readAsBytes();
    final hash = sha256.convert(bytes).toString();
    final id = await db.into(db.pdfMediaAssets).insert(
          PdfMediaAssetsCompanion.insert(
            sourceFileId: Value(sourceFileId),
            sourcePage: Value(e.pageNumber),
            fileName: Value(e.fileName),
            relativePath: Value(e.fileName),
            width: Value(e.width),
            height: Value(e.height),
            hash: Value(hash),
          ),
        );
    map[e.pageNumber] = id;
  }
  return map;
}
