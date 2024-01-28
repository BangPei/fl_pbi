import 'dart:typed_data';
import 'package:fl_pbi/library/library_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:jiffy/jiffy.dart';

class SuratLunas {
  String? name;
  String? phone;
  String? address;
  String? nik;
  String? position;
  String? date;
  String? block;

  SuratLunas({
    this.address,
    this.nik,
    this.phone,
    this.name,
    this.position,
    this.block,
    this.date,
  });

  SuratLunas.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phone = json['phone'];
    address = json['address'];
    position = json['position'];
    date = json['date'] == null
        ? json['date']
        : Jiffy.parseFromDateTime(json['date']).format(pattern: "dd MMMM yyyy");
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
            "SURAT KETERANGAN LUNAS",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.SizedBox(height: 40),
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
                    text: 'Posisi',
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
                      text: position ?? "",
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
        pw.SizedBox(height: 25),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
              style: const pw.TextStyle(lineSpacing: 2.0 * PdfPageFormat.mm),
              text:
                  "\t\t\t\t\t\t\t\t\t\tDengan ini kami informasikan bahwa pembayaran Ruko Blok ${block ?? '.......................'} yang beralamat di Bumi Indah telah",
              children: [
                pw.TextSpan(
                  text: ' LUNAS',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                )
              ]),
        ),
        pw.SizedBox(height: 5.0 * PdfPageFormat.mm),
        pw.Paragraph(
          text:
              "\t\t\t\t\t\t\t\t\t\tDemikiansurat keterangan ini dibuat dengan sebenar-benarnya dan agar dipergunakan sebagai mestinya.",
        ),
        pw.SizedBox(height: 40),
        pw.Paragraph(
            text: "Tangerang, ${date ?? ''}",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm)),
        pw.Paragraph(
            text: "Pengelola",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm)),
        pw.SizedBox(height: 70),
        pw.Paragraph(
            text: "(${name ?? '.........................................'})"
                .toUpperCase(),
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
