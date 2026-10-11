import 'package:food_ration/database/app_database.dart';

import 'extracted_pdf_page_image.dart';

Future<Map<int, int>> registerExtractedPageImages(
  AppDatabase db, {
  required String absoluteImageDirectory,
  required List<ExtractedPdfPageImage> extracted,
  String? sourceFileId,
}) async {
  throw UnsupportedError(
    'registerExtractedPageImages is only available on IO platforms.',
  );
}
