/// One PDF page worth of plain text (1-based [pageNumber] as in PDF viewers).
class PdfTextPage {
  PdfTextPage({required this.pageNumber, required this.text});

  final int pageNumber;
  final String text;
}

/// Splits a dump that contains markers like `-- 1 of 97 --` into [PdfTextPage] segments.
List<PdfTextPage> splitTextByPdfPageMarkers(String fullText) {
  final marker = RegExp(
    r'--\s*(\d+)\s+of\s+\d+\s*--',
    caseSensitive: false,
  );
  final pages = <PdfTextPage>[];
  var start = 0;
  int? pendingPage;
  for (final m in marker.allMatches(fullText)) {
    final pageNum = int.tryParse(m.group(1) ?? '');
    if (pageNum == null) continue;
    if (pendingPage != null) {
      final chunk = fullText.substring(start, m.start).trim();
      if (chunk.isNotEmpty) {
        pages.add(PdfTextPage(pageNumber: pendingPage, text: chunk));
      }
    }
    pendingPage = pageNum;
    start = m.end;
  }
  if (pendingPage != null && start < fullText.length) {
    final chunk = fullText.substring(start).trim();
    if (chunk.isNotEmpty) {
      pages.add(PdfTextPage(pageNumber: pendingPage, text: chunk));
    }
  }
  if (pages.isEmpty && fullText.trim().isNotEmpty) {
    pages.add(PdfTextPage(pageNumber: 1, text: fullText.trim()));
  }
  return pages;
}
