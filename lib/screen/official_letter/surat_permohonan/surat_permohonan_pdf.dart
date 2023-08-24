import 'dart:typed_data';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/permohonan.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class SuratPermohonanPDF extends StatefulWidget {
  final SuratPermohonan? data;
  const SuratPermohonanPDF({super.key, this.data});

  @override
  State<SuratPermohonanPDF> createState() => _SuratPermohonanPDFState();
}

class _SuratPermohonanPDFState extends State<SuratPermohonanPDF> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        children: [
          IconButton(
              onPressed: () async {
                await Printing.layoutPdf(
                    onLayout: (format) =>
                        _generatePdf(format, "Data Title", context));
              },
              icon: const Icon(Icons.print)),
          Expanded(
            child: PdfPreview(
              maxPageWidth: 700,
              build: (format) => _generatePdf(format, "Data Title", context),
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
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, String title, BuildContext cc) async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );
    final font1 = await PdfGoogleFonts.tinosRegular();
    final font2 = await PdfGoogleFonts.tinosBold();
    final image = await imageFromAssetBundle('images/logo.png');

    pdf.addPage(pw.MultiPage(
      pageFormat: format.copyWith(
        marginBottom: 1.5 * PdfPageFormat.cm,
        marginLeft: 35,
        marginRight: 35,
        marginTop: 35,
      ),
      theme: pw.ThemeData.withFont(
        base: font1,
        bold: font2,
      ),
      orientation: pw.PageOrientation.portrait,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) => Common.headers(image),
      build: (context) => [
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            "SURAT PERMOHONAN",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.SizedBox(height: 25),
        pw.Paragraph(
          text: "Kepada Yth,\nPengurus Perniagaan Bumi Indah\nDi Tempat",
        ),
        pw.SizedBox(height: 20),
        pw.Paragraph(
          text: "Dengan Hormat.",
        ),
        pw.SizedBox(height: 5),
        pw.Paragraph(
          text: "Yang bertandatangan dibawah ini :",
        ),
        pw.SizedBox(height: 5),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Paragraph(
                    text: 'Nama',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: 'Nik',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: 'No. Telp',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: 'Alamat',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
              ],
            ),
            pw.SizedBox(width: 100),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Paragraph(
                    text: ':',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: ':',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: ':',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: ':',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
              ],
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Paragraph(
                      text: widget.data?.name ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.Paragraph(
                      text: widget.data?.nik ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.Paragraph(
                      text: widget.data?.phone ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.Text(
                    widget.data?.address ?? "",
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                      lineSpacing: 2,
                    ),
                  ),
                  pw.SizedBox(width: 3 * PdfPageFormat.mm),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 25),
        pw.Paragraph(
          text:
              "Memohon kepada Pengurus Perniagaan Bumi Indah untuk pemakaian lahan yang ditunjuk untuk saya gunakan berdagang/usaha sebelum lahan tersebut digunakan oleh pihak pengurus Perniagaan Bumi Indah.",
        ),
        pw.Paragraph(
          text:
              "Adapun hal dan peraturan dari Pengurus Perniagaan Bumi Indah akan dipatuhi.",
        ),
        pw.Paragraph(
          text:
              "Demikian surat permohonan ini saya ajukan dan besar harapan saya Pengurus Perniagaan Bumi Indah dapat mengabulkannya, sebelum dan sesudahnya saya ucapkan terimakasih.",
        ),
        pw.SizedBox(height: 25),
        pw.Paragraph(
            text: "Hormat Kami",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm)),
        pw.SizedBox(height: 70),
        pw.Paragraph(
            text: "(${widget.data?.name})",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm))
      ],
    ));
    return pdf.save();
  }
}
