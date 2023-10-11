import 'dart:typed_data';
import 'package:fl_pbi/library/common.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:fl_pbi/models/customer.dart';
import 'package:fl_pbi/models/kios.dart';
import 'package:fl_pbi/models/pic.dart';

class HakGuna {
  String? no;
  String? createdAt;
  String? createdPlace;
  Pic? pic;
  Customer? customer;
  Kios? kios;

  HakGuna(
      {this.no,
      this.createdAt,
      this.createdPlace,
      this.pic,
      this.customer,
      this.kios});

  HakGuna.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    createdAt = json['created_at'];
    createdPlace = json['created_place'];
    pic = json['pic'] != null ? Pic.fromJson(json['pic']) : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    kios = json['kios'] != null ? Kios.fromJson(json['kios']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no'] = no;
    data['created_at'] = createdAt;
    data['created_place'] = createdPlace;
    if (pic != null) {
      data['pic'] = pic!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (kios != null) {
      data['kios'] = kios!.toJson();
    }
    return data;
  }

  pw.Widget lineWithNumber({
    required String textNum,
    double? leftPadding,
    required pw.Widget child,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5.0 * PdfPageFormat.mm),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
              padding: pw.EdgeInsets.only(left: leftPadding ?? 0),
              child: pw.SizedBox(
                width: 20,
                child: pw.Text(textNum),
              )),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: child,
          )
        ],
      ),
    );
  }

  pw.Widget rowIdentity(String title, String data, {double? titleWidh}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.SizedBox(width: titleWidh ?? 100, child: pw.Text(title)),
          pw.SizedBox(width: 20, child: pw.Text(":")),
          pw.Expanded(
            child: pw.Text(
              data,
              textAlign: pw.TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> perjanjianPdf() async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );
    final font1 = await PdfGoogleFonts.tinosRegular();
    final font2 = await PdfGoogleFonts.tinosBold();
    final image = await imageFromAssetBundle('images/logo.png');
    final oCcy = NumberFormat("#,###", "en_US");
    String day = (createdAt == null)
        ? '............'
        : Jiffy.parse(createdAt!, pattern: "dd MMMM yyyy")
            .format(pattern: 'EEEE');
    String dateNum = createdAt == null
        ? '........'
        : Jiffy.parse(createdAt!, pattern: "dd MMMM yyyy").format(pattern: 'd');
    String month = createdAt == null
        ? '........'
        : Jiffy.parse(createdAt!, pattern: "dd MMMM yyyy")
            .format(pattern: 'MMMM');
    String year = createdAt == null
        ? '........'
        : Jiffy.parse(createdAt!, pattern: "dd MMMM yyyy")
            .format(pattern: 'yyyy');

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
          child: pw.Container(
            width: 385,
            alignment: pw.Alignment.centerRight,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  width: 1,
                  color: PdfColors.black,
                ),
              ),
            ),
            child: pw.Center(
              child: pw.Text(
                "SURAT PERJANJIAN KONTRAK HAK GUNA PAKAI KIOS",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Center(
          child: pw.Text(
            "Nomor : ${no ?? '.....................................'}",
            style: const pw.TextStyle(fontSize: 14),
          ),
        ),
        pw.SizedBox(height: 25),
        pw.Paragraph(text: ""),
        pw.Paragraph(
          text: "Yang bertandatangan dibawah ini :",
        ),
        rowIdentity("Nama", ""),
        rowIdentity("No. KTP", ""),
        rowIdentity("Tanggal Lahir", ""),
        rowIdentity("No. Telp", ""),
        rowIdentity("Pekerjaan", ""),
        rowIdentity("Alamat", ""),
        pw.SizedBox(height: 15),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: const pw.TextStyle(
              lineSpacing: 1.5 * PdfPageFormat.mm,
            ),
            text: 'Yang selanjutnya disebut ',
            children: [
              pw.TextSpan(
                text: 'PIHAK PERTAMA.',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              )
            ],
          ),
        ),
        pw.SizedBox(height: 15),
        rowIdentity("Nama", ""),
        rowIdentity("No. KTP", ""),
        rowIdentity("No. Telp", ""),
        rowIdentity("Pekerjaan", ""),
        rowIdentity("Alamat", ""),
        pw.SizedBox(height: 15),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: const pw.TextStyle(
              lineSpacing: 1.5 * PdfPageFormat.mm,
            ),
            text: 'Yang selanjutnya disebut ',
            children: [
              pw.TextSpan(
                text: 'PIHAK KEDUA.',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              )
            ],
          ),
        ),
        pw.SizedBox(height: 15),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: const pw.TextStyle(
              lineSpacing: 1.5 * PdfPageFormat.mm,
            ),
            text:
                '\t\t\t\t\t\t\t\t\t\t\t\tPada hari ini $day Tanggal $dateNum Bulan $month Tahun $year ',
            children: [
              pw.TextSpan(
                text: 'PIHAK PERTAMA',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              const pw.TextSpan(text: 'dan'),
              pw.TextSpan(
                text: 'PIHAK KEDUA ',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              const pw.TextSpan(
                  text:
                      'telah sepakat dan menyetujui untuk menandatangani surat perjanjian Hak Guna Pakai Kios untuk berdagang atau berusaha di “PERNIAGAAN BUMI INDAH” Jl Bumi Indah Raya, Kelurahan Kuta Jaya, Kecamatan Pasarkemis, Kabupaten Tangerang, Provinsi Banten, yang isi serta syarat-syarat perjanjiannya diatur sebagai berikut :'),
            ],
          ),
        ),
        pw.SizedBox(height: 15),
        lineWithNumber(
          textNum: "1. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              children: [
                pw.TextSpan(
                  text: 'PIHAK PERTAMA ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      'setuju untuk memberikan hak guna pakai dan menyewakan kios kepada  ',
                ),
                pw.TextSpan(
                  text: 'PIHAK KEDUA ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                    text:
                        "yaitu berupa unit bangunan kios dengan data dan syarat-syarat sebagai berikut :"),
              ],
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "a.\t\t\t\t\tLokasi Kios",
            kios?.location ?? '............................................',
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity("b.\t\t\t\t\tTanda Daftar Hak Guna Pakai Perunit",
              kios?.location ?? '............................................',
              titleWidh: 230),
        ),
        lineWithNumber(
          textNum: "2. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      'bersedia menyewa lahan yang dimaksud dalam perjanjian ini, yang hanya akan digunakan untuk tempat usaha ',
                ),
                pw.TextSpan(
                  text: "kuliner.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "3. ",
          child: pw.Text(""),
        ),
        lineWithNumber(
          textNum: "4. ",
          child: pw.Text(""),
        ),
        lineWithNumber(
          textNum: "5. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text:
                  'Membangun bangunan semi permanen atau permanen harus ijin ',
              children: [
                pw.TextSpan(
                  text: "Pihak Pertama.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "6. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "bertanggung jawab menjaga dan memelihara kebersihan lingkungan di sekitar tempat usaha tersebut.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "7. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "wajib ijin koordinasi dengan lingkungan terdekat (Rt/Rw) dan Security Komplek.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "8. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "dilarang keras memanfaatkan lahan sewa tersebut untuk kegiatan usaha atau kegiatan lainnya yang melanggar kesusilaan yang melanggar peraturan perundangan yang berlaku.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "9. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "berhak memutus perjanjian sewa lahan ini secara sepihak jika dikemudian hari ",
                ),
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "melakukan pelanggaran sebagaimana tercantum dalam poin 8 tersebut diatas, dan untuk selanjutnya ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "akan melaporkan kepada pihak berwajib.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "10.",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text:
                  'Jika dikemudian hari karena alasan rencana pembangunan dari ',
              children: [
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "atau karena alasan lainnya yang mengharuskan ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "mengakhiri/memutus secara sepihak perjanjian ini, maka kedua belah pihak sepakat akan menyelesaikannya secara musyawarah mufakat tanpa adanya paksaan/tuntutan dari ",
                ),
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "Kepada ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "untuk mengganti kerugian yang ditimbulkan kepada ",
                ),
                pw.TextSpan(
                  text: "Pihak Kedua.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "11. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "akan membersihkan material, sampah, limbah atau sisa bangunannya apabila lahan akan dipakai atau masa kontrak sudah habis.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "12. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "akan memberitahukan sekurang - kurangnya dalam waktu 1 (satu) bulan sebelum ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "mengakhiri perjanjian ini secara sepihak sebagaimana dimaksud pada poin 10 tersebut diatas.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "13. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: 'Penyerahan lahan yang digunakan tersebut kepada ',
              children: [
                pw.TextSpan(
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "telah terjadi pada saat perjanjian ini ditandatangani dalam keadaan baik oleh kedua belah pihak.",
                ),
              ],
            ),
          ),
        ),
        pw.Spacer(),
        pw.Text(
          "Pihak Pertama",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              width: 200,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Paragraph(
                      text: "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.SizedBox(height: 90),
                  pw.Paragraph(
                    text: "(a)".toUpperCase(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm),
                  )
                ],
              ),
            ),
            pw.Container(
              width: 200,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Paragraph(
                      text: "Pihak Kedua",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.SizedBox(height: 90),
                  pw.Paragraph(
                    text: "(a)".toUpperCase(),
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    margin: const pw.EdgeInsets.only(
                        bottom: 3.0 * PdfPageFormat.mm),
                  )
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
