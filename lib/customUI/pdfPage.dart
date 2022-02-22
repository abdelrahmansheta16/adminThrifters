import 'dart:typed_data';

import 'package:barcode/barcode.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import '../constants.dart';

class PdfPage extends StatefulWidget {
  final String data;
  const PdfPage({Key key, this.data}) : super(key: key);

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => generatePdf(format, widget.data),
    );
  }




}
