import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PDFMainLayout<T> extends StatefulWidget {
  final T data;
  final String fileName;
  final Future<Uint8List> pdf;
  const PDFMainLayout({
    super.key,
    required this.data,
    required this.pdf,
    required this.fileName,
  });

  @override
  State<PDFMainLayout> createState() => _PDFMainLayoutState();
}

class _PDFMainLayoutState extends State<PDFMainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Printing.layoutPdf(onLayout: (format) => widget.pdf);
              },
              icon: const Icon(Icons.print)),
        ],
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        build: (format) => widget.pdf,
        canDebug: false,
        canChangeOrientation: false,
        allowSharing: false,
        canChangePageFormat: false,
        useActions: false,
        pdfFileName:
            "Surat Permohonan ${DateTime.now().millisecond.toString()}",
        // onPrinted: _showPrintedToast,
        // onShared: _showSharedToast,
      ),
    );
  }
}
