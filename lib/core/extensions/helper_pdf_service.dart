import 'dart:developer';
import 'dart:io';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdf;

class HelperPdfService {
  static Future<File> saveDocument({
    required String name,
    required pdf.Document pdf,
  }) async {
    try {
      final bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');
      log("file: $file");
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      log("Failed to save document: $e");
      return Future.error("Failed to save document: $e");
    }
  }

  static Future openFile(File file) async {
    try {
      final url = file.path;
      log("openFile: $url");
      await OpenFile.open(url, type: "application/pdf");
      log("awaitOpenFile.open : $url");
    } catch (e) {
      log("Failed openFile: $e");
    }
  }

  static Future<pdf.Document> convertFileToPdfDocument(File file) async {
    final bytes = await file.readAsBytes();
    final pdfDocument = pdf.Document()
      ..addPage(pdf.Page(
        build: (context) {
          return pdf.Image(pdf.MemoryImage(bytes));
        },
      ));
    return pdfDocument;
  }
}
