import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Common {
  Common._();

  static String imageLogo = 'images/logo.png';
  static String imageDollar = 'images/OIP.png';
  static String imageProfile = 'images/profile.png';
  static String imageHome = 'images/home.png';
  static MaskTextInputFormatter ktpFormat = MaskTextInputFormatter(
    mask: '##.####.######.####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );

  static const double inch = 72.0;
  static const double cm = inch / 2.54;
  static const PdfPageFormat a4 =
      PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 2.0 * cm);

  static pw.Container headers(pw.ImageProvider image) {
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
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 80,
              height: 80,
              child: pw.Image(image),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'PERNIAGAAN BUMI INDAH',
                    style: pw.TextStyle(
                      color: PdfColors.red,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  pw.Text(
                    "Jl. Bumi Indah Raya Kel. Sukamantri Kec. Pasar Kemis 15560",
                    style: pw.TextStyle(
                      color: PdfColors.blue,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  pw.Text(
                    "HP. : 0812 9911 1123 , 0898 3311 115",
                    style: pw.TextStyle(
                      color: PdfColors.blue,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  static modalInfo(BuildContext context,
      {String? message, required String title, Icon? icon}) {
    showDialog(
      context: context,
      builder: (__) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Divider(height: 2, thickness: 3),
                icon ??
                    const FaIcon(
                      FontAwesomeIcons.circleXmark,
                      color: Colors.red,
                      size: 50,
                    ),
                Text(
                  message ?? "Message",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
