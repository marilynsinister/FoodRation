import 'package:food_ration/database/app_database.dart';

import 'meal_plan_db_importer.dart';
import 'meal_plan_media_registration.dart';
import 'meal_plan_text_parser.dart';
import 'pdf_document_loader.dart';
import 'pdf_images.dart';

/// Loads a PDF (IO), parses days/slots/recipes, optionally renders page PNGs and
/// registers [PdfMediaAssets], then imports into [AppDatabase].
Future<MealPlanDbImportResult> importMealPlanFromPdfFile(
  AppDatabase db,
  String pdfPath, {
  bool renderPageImages = false,
  String? imageOutputDirectory,
  String? sourceFileName,
  String? title,
}) async {
  final pages = await loadPdfTextPagesFromFile(pdfPath);
  final bundle = parseMealPlanTextPages(pages);

  Map<int, int>? pageToMedia;
  if (renderPageImages) {
    final dir = imageOutputDirectory;
    if (dir == null || dir.isEmpty) {
      throw ArgumentError(
        'imageOutputDirectory is required when renderPageImages is true.',
      );
    }
    final extracted = await renderPdfPagesToPngDirectory(
      pdfPath: pdfPath,
      outputDirectory: dir,
    );
    pageToMedia = await registerExtractedPageImages(
      db,
      absoluteImageDirectory: dir,
      extracted: extracted,
      sourceFileId: sourceFileName ?? pdfPath,
    );
  }

  return importParsedMealPlanBundle(
    db,
    bundle,
    sourceFileName: sourceFileName ?? pdfPath,
    title: title,
    pageNumberToMediaAssetId: pageToMedia,
  );
}
