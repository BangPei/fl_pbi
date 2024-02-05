import 'dart:typed_data';
import 'package:fl_pbi/library/library_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:fl_pbi/models/models.dart';

class TransactionReport {
  List<Transaction>? transIn;
  List<Transaction>? transOut;
  double? totalIn;
  double? totlaOut;

  TransactionReport({this.transIn, this.transOut, this.totalIn, this.totlaOut});

  TransactionReport.fromJson(Map<String, dynamic> json) {
    if (json['transIn'] != null) {
      transIn = <Transaction>[];
      json['transIn'].forEach((v) {
        transIn!.add(Transaction.fromJson(v));
      });
    }
    if (json['transOut'] != null) {
      transOut = <Transaction>[];
      json['transOut'].forEach((v) {
        transOut!.add(Transaction.fromJson(v));
      });
    }
    totalIn = double.parse(json['totalIn']);
    totlaOut = double.parse(json['totlaOut']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transIn != null) {
      data['transIn'] = transIn!.map((v) => v.toJson()).toList();
    }
    if (transOut != null) {
      data['transOut'] = transOut!.map((v) => v.toJson()).toList();
    }
    data['totalIn'] = totalIn;
    data['totlaOut'] = totlaOut;
    return data;
  }

  Future<Uint8List> pdf(
      {required String reportType, required Map<String, dynamic> map}) async {
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
            "Laporan Pemasukan ${reportType.toUpperCase()}",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.Paragraph(
          text: "Periode",
        ),
      ],
    ));
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
            "Laporan Pengeluaran ${reportType.toUpperCase()}",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.Paragraph(
          text: "Periode",
        ),
      ],
    ));
    return pdf.save();
  }
}
