import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:jiffy/jiffy.dart';
import 'package:printing/printing.dart';

import '../../../library/library_file.dart';

class SuratSewaLahan {
  String? name;
  String? phone;
  String? address;
  String? nik;
  String? ownerName;
  String? date;
  String? areaName;
  String? areaCompany;
  double? wide;
  int? extraTime;
  int? periodeRent;
  String? periodeDate;

  SuratSewaLahan({
    this.address = "......................................",
    this.nik = "......................................",
    this.phone = "......................................",
    this.name = "......................................",
    this.ownerName,
    this.date,
    this.areaName = "......................................",
    this.areaCompany,
    this.periodeDate,
    this.wide = 0,
    this.extraTime = 0,
    this.periodeRent = 0,
  });

  SuratSewaLahan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phone = json['phone'];
    address = json['address'];
    ownerName = json['ownerName'];
    date = json['date'];
    areaName = json['areaName'];
    areaCompany = json['areaCompany'];
    periodeDate = json['periodeDate'];
    wide = json['wide'];
    extraTime = json['extraTime'];
    periodeRent = json['periodeRent'];
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

  pw.Widget rowIdentity(String title, String data) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.SizedBox(width: 100, child: pw.Text(title)),
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

  Future<Uint8List> pdf() async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );
    final font1 = await PdfGoogleFonts.tinosRegular();
    final font2 = await PdfGoogleFonts.tinosBold();
    final image = await imageFromAssetBundle('images/logo.png');
    final oCcy = NumberFormat("#,###", "en_US");
    String day = (date == null)
        ? '............'
        : Jiffy.parse(date!, pattern: "yyyy-MM-DD").format(pattern: 'EEEE');
    String dateNum = date == null
        ? '........'
        : Jiffy.parse(date!, pattern: "yyyy-MM-DD").format(pattern: 'd');
    String month = date == null
        ? '........'
        : Jiffy.parse(date!, pattern: "yyyy-MM-DD").format(pattern: 'MMMM');
    String year = date == null
        ? '........'
        : Jiffy.parse(date!, pattern: "yyyy-MM-DD").format(pattern: 'yyyy');

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
            "PERJANJIAN SEWA LAHAN",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.Center(
          child: pw.Text(
            (areaCompany ?? "").toUpperCase(),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.SizedBox(height: 25),
        pw.Paragraph(
          text:
              "Pada hari ini $day Tanggal $dateNum Bulan $month Tahun $year telah ditandatangani perjanjian pemakaian lahan untuk tempat usaha oleh dan dengan :",
        ),
        lineWithNumber(
          textNum: "1. ",
          leftPadding: 30,
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: '',
              children: [
                pw.TextSpan(
                  text:
                      '${(ownerName?.toUpperCase() ?? "......................................").toUpperCase()},',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.TextSpan(
                    text:
                        ' Mewakili Perniagaan Bumi Indah yang beralamat di Jl Bumi Indah Raya Kel. Sukamantri Kec. Pasarkemis 15560. Dalam hal ini bertindak untuk dan atas nama ${areaCompany ?? "......................................"} sebagai '),
                pw.TextSpan(
                  text: '“Pihak Pertama”.',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "2. ",
          leftPadding: 30,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              rowIdentity("Nama", (name ?? "").toUpperCase()),
              rowIdentity("No. KTP", nik ?? ""),
              rowIdentity("No. Telp", phone ?? ""),
              rowIdentity("Alamat", address ?? ""),
            ],
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: const pw.TextStyle(
                lineSpacing: 1.5 * PdfPageFormat.mm,
              ),
              text: 'Sebagai penyewa/pemakai lahan yang selanjutnya disebut ',
              children: [
                pw.TextSpan(
                  text: '“Pihak Kedua.',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Paragraph(
          text:
              "Dengan ini, kedua belah pihak telah sepakat untuk mengikat diri dalam Perjanjian Pemakaian Lahan untuk tempat usaha dengan ketentuan dan syarat-syarat sebagai berikut.",
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
              text: 'Bahwa ',
              children: [
                pw.TextSpan(
                  text: 'Pihak Pertama ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      'menyewakan lahan yang terletak di lahan kosong di sekitar Perumahan Bumi Indah kepada ',
                ),
                pw.TextSpan(
                  text: 'Pihak Kedua, ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.TextSpan(
                  text:
                      'dengan luas lahan (+-) ${(wide! < 1) ? "........." : oCcy.format(wide)} m2 yang terletak di Perumahan Bumi Indah Area $areaName milik $areaCompany',
                ),
              ],
            ),
          ),
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
                  text: "kuliner ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      '/ jenis usaha yang sudah mendapat persetujuan pengelola.',
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "3. ",
          child: pw.Text(
            "Ijin pemanfaatan lahan kosong tersebut selama ${periodeRent == 0 ? '........' : periodeRent} tahun, sampai dengan ${periodeDate == null ? '.............................' : Jiffy.parse(periodeDate!).format(pattern: 'dd MMMM yyyy')}.",
          ),
        ),
        lineWithNumber(
          textNum: "4. ",
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
                      'diwajibkan membangun konblok area parkir masing - masing yang akan dipergunakan untuk kepentingan bersama.',
                ),
              ],
            ),
          ),
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
                  text: "Pihak Kedua ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "tidak diperkanankan menjual, mengalihkan atau oper alih kepada Pihak Lain tanpa ijin persetujuan dari ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "10. ",
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
          textNum: "11.",
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
          textNum: "13. ",
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
                      "sanggup dan bersedia mematuhi peraturan tata tertib dan peraturan teknis operasional di lingkungan Perniagaan Bumi Indah.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "14. ",
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
                      "berkewajiban membayar IPL Bulanan yang telah ditentukan ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "untuk kepentingan bersama.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "15. ",
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
                      "akan memberitahukan sekurang - kurangnya dalam waktu 3 (tiga) bulan sebelum ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "mengakhiri perjanjian ini secara sepihak sebagaimana dimaksud pada poin 11 tersebut diatas.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "16. ",
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
                      text: areaCompany ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.SizedBox(height: 90),
                  pw.Paragraph(
                    text:
                        "(${ownerName ?? '......................................'})"
                            .toUpperCase(),
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
                    text: "($name)".toUpperCase(),
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
