import 'pdf_text_page.dart';

Future<List<PdfTextPage>> loadPdfTextPagesFromFile(String filePath) async {
  throw UnsupportedError(
    'PDF loading is only supported on IO platforms (dart:io). '
    'Use splitTextByPdfPageMarkers with extracted text on web.',
  );
}
