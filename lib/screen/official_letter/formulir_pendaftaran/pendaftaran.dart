import 'dart:typed_data';
import 'package:fl_pbi/library/common.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class Pendaftaran {
  String? name;
  String? phone;
  String? address;
  String? nik;
  String? pic;
  String? block;

  Pendaftaran({
    this.address = "......................................",
    this.nik = "......................................",
    this.phone = "......................................",
    this.name = "......................................",
    this.pic = "......................................",
    this.block = ".....................",
  });

  Pendaftaran.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phone = json['phone'];
    address = json['address'];
    pic = json['pic'];
    block = json['block'];
  }

  Future<Uint8List> pdf() async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );
    final font1 = await PdfGoogleFonts.tinosRegular();
    final font2 = await PdfGoogleFonts.tinosBold();
    final image = await imageFromAssetBundle('images/logo.png');

    pdf.addPage(pw.MultiPage(
      pageFormat: Common.a4.copyWith(
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
            "FORMULIR PENDAFTARAN",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        pw.SizedBox(height: 60),
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
                    text: 'Block / No',
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
                      text: name ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.Paragraph(
                      text: nik ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.Paragraph(
                      text: phone ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.Paragraph(
                      text: block ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.Text(
                    address ?? "",
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
        pw.SizedBox(height: 100),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              width: 200,
              child: pw.Column(children: [
                pw.Paragraph(
                    text: "Pengelola",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm)),
                pw.SizedBox(height: 70),
                pw.Paragraph(
                    text: "($pic)".toUpperCase(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm))
              ]),
            ),
            pw.Container(
              width: 200,
              child: pw.Column(
                children: [
                  pw.Paragraph(
                      text: "Pemohon",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.SizedBox(height: 70),
                  pw.Paragraph(
                      text: "($name)".toUpperCase(),
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm))
                ],
              ),
            ),
          ],
        ),
      ],
    ));
    return pdf.save();
  }
}
