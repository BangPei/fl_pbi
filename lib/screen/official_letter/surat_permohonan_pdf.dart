import 'dart:typed_data';
import 'package:fl_pbi/screen/official_letter/permohonan.dart';
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
  SuratPermohonan _data = SuratPermohonan();

  @override
  void initState() {
    _data.name = "Muhammad Bilal Rivai";
    _data.nik = "36.0312.070389.0001";
    _data.phone = "081316007237";
    _data.address =
        "Jl Cempaka V Blok HN 17 Bumi Indah Tahap 3 Sukamantri Pasarkemis Tangerang Banten Indonesia 15560";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: PdfPreview(
        maxPageWidth: 700,
        build: (format) => _generatePdf(format, "Data Title", context),
        canDebug: false,
        canChangeOrientation: false,
        allowSharing: false,
        canChangePageFormat: false,
        pdfFileName: DateTime.now().millisecond.toString(),
        // actions: actions,
        // onPrinted: _showPrintedToast,
        // onShared: _showSharedToast,
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, String title, BuildContext cc) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      pageMode: PdfPageMode.outlines,
    );
    final image = await imageFromAssetBundle('images/logo.png');

    pdf.addPage(pw.MultiPage(
      pageFormat: format.copyWith(
        marginBottom: 1.5 * PdfPageFormat.cm,
        marginLeft: 35,
        marginRight: 35,
        marginTop: 35,
      ),
      orientation: pw.PageOrientation.portrait,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) {
        return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  width: 1,
                  color: PdfColors.indigo,
                ),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 70,
                  height: 70,
                  child: pw.Image(image),
                ),
                pw.SizedBox(width: 13),
                pw.Expanded(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'PERNIAGAAN BUMI INDAH',
                        style: pw.TextStyle(
                          color: PdfColors.red,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                      pw.Text(
                        "Jl. Bumi Indah Raya Kel. Sukamantri Kec. Pasar Kemis 15560",
                        style: pw.TextStyle(
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      pw.Text(
                        "HP. : 0812 9911 1123 , 0898 3311 115",
                        style: pw.TextStyle(
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
      build: (context) => [
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            "SURAT PERMOHONAN",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        pw.SizedBox(height: 30),
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
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Paragraph(
                    text: _data.name ?? "",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: _data.nik ?? "",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Paragraph(
                    text: _data.phone ?? "",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.Text(
                  _data.address ?? "",
                  maxLines: 3,
                  overflow: pw.TextOverflow.span,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                pw.SizedBox(width: 3 * PdfPageFormat.mm),
              ],
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
        pw.Container(
            width: MediaQuery.of(cc).size.width / 3,
            child: pw.Column(children: [
              pw.Paragraph(
                  text: "Hormat Kami",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                  margin:
                      const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm)),
              pw.SizedBox(height: 60),
              pw.Paragraph(
                  text: "(${_data.name})",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                  margin:
                      const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm)),
              pw.SizedBox(height: 50)
            ]))
      ],
    ));
    return pdf.save();
  }
}
