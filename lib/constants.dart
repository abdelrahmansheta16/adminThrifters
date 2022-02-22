import 'dart:typed_data';

import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:barcode/barcode.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePdf(PdfPageFormat format, String data) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.nunitoExtraLight();

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Center(
            child: pw.Container(
                height: 100,
                width: 200,
                child: pw.BarcodeWidget(
                    data: data,
                    barcode: Barcode.fromType(BarcodeType.Code128))));
      },
    ),
  );
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
  return pdf.save();
}
