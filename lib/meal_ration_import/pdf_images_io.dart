import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:pdfrx_engine/pdfrx_engine.dart';

import 'extracted_pdf_page_image.dart';

Uint8List bgraPixelsToPng(Uint8List bgra, int width, int height) {
  final image = img.Image(width: width, height: height);
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final i = (y * width + x) * 4;
      final b = bgra[i];
      final g = bgra[i + 1];
      final r = bgra[i + 2];
      final a = bgra[i + 3];
      image.setPixelRgba(x, y, r, g, b, a);
    }
  }
  return Uint8List.fromList(img.encodePng(image));
}

/// Renders each PDF page to a PNG file in [outputDirectory] (e.g. app support dir).
Future<List<ExtractedPdfPageImage>> renderPdfPagesToPngDirectory({
  required String pdfPath,
  required String outputDirectory,
  int maxWidth = 1200,
}) async {
  await pdfrxInitialize();
  final dir = Directory(outputDirectory);
  await dir.create(recursive: true);
  final doc = await PdfDocument.openFile(pdfPath);
  final out = <ExtractedPdfPageImage>[];
  try {
    for (final page in doc.pages) {
      final w = maxWidth;
      final h = (page.height * w / page.width).round().clamp(1, 100000);
      final image = await page.render(width: w, height: h);
      if (image == null) continue;
      try {
        final png = bgraPixelsToPng(image.pixels, image.width, image.height);
        final name = 'page_${page.pageNumber}.png';
        await File(p.join(outputDirectory, name)).writeAsBytes(png);
        out.add(ExtractedPdfPageImage(
          pageNumber: page.pageNumber,
          fileName: name,
          width: image.width,
          height: image.height,
        ));
      } finally {
        image.dispose();
      }
    }
  } finally {
    await doc.dispose();
  }
  return out;
}

/// SHA-256 hex of file bytes (for [PdfMediaAssets.hash]).
Future<String> sha256File(String filePath) async {
  final bytes = await File(filePath).readAsBytes();
  return sha256.convert(bytes).toString();
}
