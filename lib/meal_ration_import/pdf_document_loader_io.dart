import 'dart:io';

import 'package:pdfrx_engine/pdfrx_engine.dart';

import 'pdf_text_page.dart';

/// Loads plain text per page using pdfium (pdfrx). Page numbers are 1-based.
Future<List<PdfTextPage>> loadPdfTextPagesFromFile(String filePath) async {
  await pdfrxInitialize();
  final f = File(filePath);
  if (!await f.exists()) {
    throw FileSystemException('PDF not found', filePath);
  }
  final doc = await PdfDocument.openFile(filePath);
  final out = <PdfTextPage>[];
  try {
    for (final page in doc.pages) {
      final raw = await page.loadText();
      final text = raw?.fullText ?? '';
      out.add(PdfTextPage(pageNumber: page.pageNumber, text: text));
    }
  } finally {
    await doc.dispose();
  }
  return out;
}
