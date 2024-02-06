import 'dart:typed_data';
import 'package:fl_pbi/library/library_file.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:fl_pbi/models/models.dart';

class TransactionReport {
  List<Transaction>? transIn;
  List<Transaction>? transOut;
  double? totalIn;
  double? totalOut;

  TransactionReport({this.transIn, this.transOut, this.totalIn, this.totalOut});

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
    totalOut = double.parse(json['totalOut']);
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
    data['totalOut'] = totalOut;
    return data;
  }

  Future<Uint8List> pdf({
    required String reportType,
    required Map<String, dynamic> map,
  }) async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );
    final font1 = await PdfGoogleFonts.tinosRegular();
    final font2 = await PdfGoogleFonts.tinosBold();
    final image = await imageFromAssetBundle('images/logo.png');
    List<String> tableHeader = [
      "NO",
      "Kode Transaksi",
      "Tanggal",
      "Rupiah",
      "Keterangan"
    ];
    if (reportType.toLowerCase() == "ipl") {
      tableHeader.add("Block");
    }
    pdf.addPage(transactionSection(
      font1: font1,
      font2: font2,
      image: image,
      map: map,
      data: transIn ?? [],
      total: totalIn ?? 0,
      tableHeader: tableHeader,
      title: "Laporan Pemasukan ${reportType.toUpperCase()}",
    ));
    pdf.addPage(transactionSection(
      font1: font1,
      font2: font2,
      image: image,
      map: map,
      data: transOut ?? [],
      total: totalOut ?? 0,
      tableHeader: tableHeader,
      title: "Laporan Pengeluaran ${reportType.toUpperCase()}",
    ));
    return pdf.save();
  }

  pw.MultiPage transactionSection({
    required pw.Font font1,
    required pw.Font font2,
    required pw.ImageProvider image,
    required String title,
    required double total,
    required List<String> tableHeader,
    required List<Transaction> data,
    required Map<String, dynamic> map,
  }) {
    bool isMonth = map.containsKey('month');
    String periode = 'Periode';
    if (isMonth) {
      periode = "${map['month'].toUpperCase()} ${map['year']}";
    } else {
      periode =
          "${Jiffy.parse(map['from']).format(pattern: "d MMM yyyy")} - ${Jiffy.parse(map['to']).format(pattern: "d MMM yyyy")}";
    }
    return pw.MultiPage(
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
      footer: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
          child: pw.Text(
            'Halaman ${context.pageNumber} dari ${context.pagesCount}',
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  color: PdfColors.black,
                ),
          ),
        );
      },
      build: (context) => [
        pw.SizedBox(height: 10),
        pw.Center(
          child: pw.Text(
            title,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.SizedBox(height: 25),
        pw.Row(
          children: [
            pw.Expanded(
              child: rowHeader("Periode", periode),
            ),
            pw.Expanded(
              child: rowHeader(
                "Total",
                'Rp. ${Common.oCcy.format(total)}',
              ),
            )
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Paragraph(
          text: "Detail Transaksi",
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.TableHelper.fromTextArray(
          headers: List<String>.generate(
            tableHeader.length,
            (col) => tableHeader[col],
          ),
          data: List<List<String>>.generate(
            data.length,
            (row) => List<String>.generate(
              tableHeader.length,
              (col) => data[row].getIndex(row, col),
            ),
          ),
          cellAlignments: {
            0: pw.Alignment.centerRight,
            1: pw.Alignment.center,
            2: pw.Alignment.center,
            3: pw.Alignment.centerRight,
            4: pw.Alignment.center,
          },
        )
      ],
    );
  }

  pw.Widget rowHeader(String label, String data) {
    return pw.Row(children: [
      pw.SizedBox(
        width: 70,
        child: pw.Text(
          label,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
      pw.SizedBox(
        width: 10,
        child: pw.Text(
          ':',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
      pw.SizedBox(
        width: 300,
        child: pw.Text(
          data,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    ]);
  }
}
