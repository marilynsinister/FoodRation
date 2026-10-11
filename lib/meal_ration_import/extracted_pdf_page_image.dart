/// One full-page render exported from a PDF.
class ExtractedPdfPageImage {
  ExtractedPdfPageImage({
    required this.pageNumber,
    required this.fileName,
    required this.width,
    required this.height,
  });

  final int pageNumber;
  final String fileName;
  final int width;
  final int height;
}
