import 'package:flutter/foundation.dart';
import 'package:excel/excel.dart';
import 'package:universal_html/html.dart' as html;

class ExcelExportHelper {
  static int _lastExportTime = 0;

  static Future<void> exportToExcel({
    required List<String> headers,
    required List<List<dynamic>> rows,
    required String fileName,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    // Prevent multiple exports within 1 second
    if (now - _lastExportTime < 1000) return;
    _lastExportTime = now;

    try {
      var excel = Excel.createExcel();

      // The excel package creates 'Sheet1' by default.
      // Rename it to 'Data' to be more descriptive and avoid extra sheets.
      const String sheetName = 'Data';
      if (excel.tables.containsKey('Sheet1')) {
        excel.rename('Sheet1', sheetName);
      }
      Sheet sheetObject = excel[sheetName];

      // Add headers
      for (var i = 0; i < headers.length; i++) {
        var cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
        );
        cell.value = TextCellValue(headers[i]);
        cell.cellStyle = CellStyle(
          bold: true,
          backgroundColorHex: ExcelColor.fromHexString('#F3F4F6'),
        );
      }

      // Add rows
      for (var i = 0; i < rows.length; i++) {
        for (var j = 0; j < rows[i].length; j++) {
          var cell = sheetObject.cell(
            CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1),
          );
          var value = rows[i][j];
          if (value is String) {
            cell.value = TextCellValue(value);
          } else if (value is int) {
            cell.value = IntCellValue(value);
          } else if (value is double) {
            cell.value = DoubleCellValue(value);
          } else if (value is bool) {
            cell.value = BoolCellValue(value);
          } else {
            cell.value = TextCellValue(value.toString());
          }
        }
      }

      // Generate Excel file bytes
      // Use encode() instead of save() to avoid automatic download triggered by the package on web
      var fileBytes = excel.encode();
      if (fileBytes != null) {
        final blob = html.Blob([fileBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);

        // Use a more direct approach for download (no variable assignment to avoid lint)
        html.AnchorElement(href: url)
          ..setAttribute("download", "$fileName.xlsx")
          ..click();

        // Small delay before revoking to ensure download starts
        await Future.delayed(const Duration(milliseconds: 500));
        html.Url.revokeObjectUrl(url);
      }
    } catch (e) {
      debugPrint('Export failed: $e');
    }
  }
}
