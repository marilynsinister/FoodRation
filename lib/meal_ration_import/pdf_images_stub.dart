import 'extracted_pdf_page_image.dart';

/// See [renderPdfPagesToPngDirectory] on IO.
Future<List<ExtractedPdfPageImage>> renderPdfPagesToPngDirectory({
  required String pdfPath,
  required String outputDirectory,
  int maxWidth = 1200,
}) async {
  throw UnsupportedError(
    'PDF page rendering is only available on IO platforms.',
  );
}
