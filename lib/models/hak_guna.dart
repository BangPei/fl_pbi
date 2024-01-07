import 'dart:typed_data';
import 'package:fl_pbi/library/common.dart';
// import 'package:intl/intl.dart';
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
      padding: const pw.EdgeInsets.only(bottom: PdfPageFormat.mm),
      // padding: const pw.EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.SizedBox(
              width: titleWidh ?? 100,
              child: pw.Text(title, style: const pw.TextStyle(fontSize: 11))),
          pw.SizedBox(width: 20, child: pw.Text(":")),
          pw.Expanded(
            child: pw.Text(
              data,
              textAlign: pw.TextAlign.justify,
              style: const pw.TextStyle(fontSize: 11),
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
    // final oCcy = NumberFormat("#,###", "en_US");
    double lineSpacing = 1.2 * PdfPageFormat.mm;
    String day = (createdAt == null)
        ? '............'
        : Jiffy.parse(createdAt!, pattern: "yyyy-MM-dd")
            .format(pattern: 'EEEE');
    String dateNum = createdAt == null
        ? '........'
        : Jiffy.parse(createdAt!, pattern: "yyyy-MM-dd").format(pattern: 'd');
    String month = createdAt == null
        ? '........'
        : Jiffy.parse(createdAt!, pattern: "yyyy-MM-dd")
            .format(pattern: 'MMMM');
    String year = createdAt == null
        ? '........'
        : Jiffy.parse(createdAt!, pattern: "yyyy-MM-dd")
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
        pw.Center(
          child: pw.Container(
            width: 358,
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
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Center(
          child: pw.Text(
            "Nomor : ${no ?? '.....................................'}",
            style: const pw.TextStyle(fontSize: 12),
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Paragraph(
          text: "Yang bertandatangan dibawah ini :",
          style: const pw.TextStyle(fontSize: 11),
        ),
        rowIdentity("Nama", pic?.name ?? ""),
        rowIdentity("No. KTP", pic?.nik ?? ""),
        rowIdentity(
            "Tanggal Lahir",
            pic?.dateBirth != null
                ? Jiffy.parse(pic!.dateBirth!).format(pattern: "dd MMMM yyyy")
                : ""),
        rowIdentity("No. Telp", pic?.phone ?? ""),
        rowIdentity("Pekerjaan", pic?.job ?? ""),
        rowIdentity("Alamat", pic?.address ?? ""),
        pw.SizedBox(height: 10),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
            text: 'Yang selanjutnya disebut ',
            children: [
              pw.TextSpan(
                text: 'PIHAK PERTAMA.',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              )
            ],
          ),
        ),
        pw.SizedBox(height: 10),
        rowIdentity("Nama", customer?.name ?? ""),
        rowIdentity("No. KTP", customer?.nik ?? ""),
        rowIdentity("No. Telp", customer?.phone ?? ""),
        rowIdentity("Pekerjaan", customer?.job ?? ""),
        rowIdentity("Alamat", customer?.address ?? ""),
        pw.SizedBox(height: 10),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
            text: 'Yang selanjutnya disebut ',
            children: [
              pw.TextSpan(
                text: 'PIHAK KEDUA.',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              )
            ],
          ),
        ),
        pw.SizedBox(height: 20),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
            text:
                '\t\t\t\t\t\t\t\t\t\t\t\tPada hari ini $day Tanggal $dateNum Bulan $month Tahun $year ',
            children: [
              pw.TextSpan(
                text: 'PIHAK PERTAMA ',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              const pw.TextSpan(text: 'dan '),
              pw.TextSpan(
                text: 'PIHAK KEDUA ',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              const pw.TextSpan(
                  text:
                      'telah sepakat dan menyetujui untuk menandatangani surat perjanjian Hak Guna Pakai Kios untuk berdagang atau berusaha di "PERNIAGAAN BUMI INDAH" Jl Bumi Indah Raya, Kelurahan Kuta Jaya, Kecamatan Pasarkemis, Kabupaten Tangerang, Provinsi Banten, yang isi serta syarat-syarat perjanjiannya diatur sebagai berikut :'),
            ],
          ),
        ),
        pw.SizedBox(height: 15),
        lineWithNumber(
          textNum: "1. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
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
          child: rowIdentity(
            "b.\t\t\t\t\tBlok / Nomor",
            (kios?.block == null || kios?.blockNo == null)
                ? '............................................'
                : '${kios?.block} ${kios?.blockNo}',
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "c.\t\t\t\t\tJumlah Unit Kios",
            (kios?.totalKios == 0 || kios?.totalKios == null)
                ? '............................................'
                : "${kios?.totalKios ?? 0} Unit",
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "d.\t\t\t\t\tLuas Ukuran Kios",
            kios?.kiosWide ?? '............................................',
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "e.\t\t\t\t\tJangka Waktu Hak Guna",
            (kios?.periodeRent == 0 || kios?.periodeRent == null)
                ? '............................................'
                : "${kios?.periodeRent} Tahun",
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "f.\t\t\t\t\tMulai Waktu Hak Guna",
            kios?.startDate != null
                ? Jiffy.parse(kios!.startDate!).format(pattern: "dd MMMM yyyy")
                : '............................................',
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "g.\t\t\t\t\tTanda Daftar Hak Guna Pakai Perunit",
            kios?.signHakGuna ?? '............................................',
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "h.\t\t\t\t\tMasa Berlaku Hak Guna Pakai",
            kios?.endDate != null
                ? Jiffy.parse(kios!.endDate!).format(pattern: "dd MMMM yyyy")
                : '............................................',
            titleWidh: 230,
          ),
        ),
        pw.SizedBox(height: 10),
        lineWithNumber(
          textNum: "2. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      'menyatakan sanggup menerima dan menyetujui ketentuan dan syarat-syarat dalam perjanjian hak guna pakai Kios di "Perniagaan Bumi Indah" sebagaimana tersebut dalam poin 1 (satu) diatas.',
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "3. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK PERTAMA  ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "menjamin keberlangsungan kegiatan usaha dalam hal penggunaan dan pemakaian kios oleh PIHAK KEDUA sampai dengan batas waktu berakhirnya masa perjanjian hak guna pakai kios ini.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "4. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA  ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "sanggup dan bersedia untuk tidak melakukan aktifitas dan kegiatan usaha yang bertentangan dengan hukum dan norma-norma sosial yang berkembang di masyarakat sekitar seperti kegiatan : Berjudi atau Perjudian, Minuman keras yang memabukan, penyalahgunaan Narkotika, tindakan Asusila, serta kegiatan atau usaha lain yang akan mengganggu keamanan, ketertiban dan kenyamanan kawasan 'Perniagaan Bumi Indah'.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA  ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "sanggup dan bersedia menjaga keamanan, ketertiban, kebersihan dan kenyamanan dialam kios dan sekitarnya.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: 'Dalam masa jangka waktu berlakunya Surat Perjanjian ini, ',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "berhak atau diperbolehkan untuk mengalihkan hak guna pakai kios atau mengontrakkan kembali kepada PIHAK KETIGA dengan terlebih dahulu memberitahukan dan mendapat surat persetujuan tertulis dari PIHAK PERTAMA.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "tidak diperbolehkan merubah struktur dan instalasi dari unit kios tersebut tanpa ijin dan persetujuan dari PIHAK PERTAMA.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA  ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "berkewajiban membayar IPL Bulanan yang telah ditentukan ",
                ),
                pw.TextSpan(
                  text: "Pihak Pertama  ",
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
          textNum: "9. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      'sanggup dan bersedia mematuhu peraturan tata tertib dan peraturan teknis operasional di lingkungan kios "PERNIAGAAN BUMI INDAH".',
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "sanggup dan bersedia mentaati peraturan-peraturan pemerintah baik pemerintah tingkat pusat, daerah dan wilayah khususnya yang menyangkut Iuran Retribusi resmi dan ketentuan lainnya.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text:
                  'Setelah berakhir masa jangka waktu Hak Guna Pakai sesuai surat perjanjian ini, ',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "wajib segera mengosongkan unit kios dan menyerahkannya kembali kepada ",
                ),
                pw.TextSpan(
                  text: "PIHAK PERTAMA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "dengan terlebih dahulu menyelesaikan seluruh kewajibannya kepada ",
                ),
                pw.TextSpan(
                  text: "PIHAK PERTAMA.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: 'Jika ',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "bermaksud untuk melanjutkan Hak Guna Pakai kios setelah masa kontraknya akan berakhir, maka ",
                ),
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "harus menyampaikannya secara tertulis kepada ",
                ),
                pw.TextSpan(
                  text: "PIHAK PERTAMA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "selambat-lambatnya 30 (tiga puluh) hari sebelum masa kontraknya berakhir untuk mendapatkan persetujuan dari ",
                ),
                pw.TextSpan(
                  text: "PIHAK PERTAMA.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK PERTAMA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "akan memberikan prioritas dan perhatian kepada ",
                ),
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "yang akan memperpanjang masa kontrak hak guna pakai kiosnya dengan syarat mengajukan permohonan perpanjangan kontrak selambat-lambatnya 30 hari sebelum masa kontrak pertama berakhir.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: 'Jika dikemudian hari ',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "melakukan pelanggaran perjanjian ini maka ",
                ),
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "bersedia menerima sanksi dari ",
                ),
                pw.TextSpan(
                  text: "PIHAK PERTAMA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "selaku penanggung jawab dan pengelola Perniagaan, baik sanksi administratif sampai dengan penutupan tempat kegiatan usaha.",
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK PERTAMA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "dan ",
                ),
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      'sepakat bahwa hal-hal yang belum diatur dalam perjanjian ini yaitu peraturan tata tertib dan teknis operasional kegiatan di "PERNIAGAAN BUMI INDAH", maka akan dibuat peraturan dan teknis operasional secara terpisah dari perjanjian ini oleh ',
                ),
                pw.TextSpan(
                  text: "PIHAK PERTAMA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      'selaku penanggung jawab pengelolaan kios "PERNIAGAAN BUMI INDAH" dengan memperhatikan masukan dari ',
                ),
                pw.TextSpan(
                  text: "PIHAK KEDUA.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: '',
              children: [
                pw.TextSpan(
                  text: "PIHAK PERTAMA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "dan ",
                ),
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text:
                      "bersepakat untuk menempuh jalan musyawarah dan mufakat untuk menyelesaikan hal-hal atau perselisihan yang mungkin timbulberkaitan dengan isi Surat Perjanjian ini.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "17. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text:
                  'Setelah disepakati kontrak ini oleh kedua belah pihak, maka ',
              children: [
                pw.TextSpan(
                  text: "PIHAK KEDUA ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: "wajib segera menempati kios yang sudah ditentukan.",
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "18. ",
          child: pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text:
                  'Surat Perjanjian ini dibuat dalam rangkap dua untuk masing-masing pihak.',
            ),
          ),
        ),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
            text:
                '\t\t\t\t\t\t\t\t\t\t\t\tDemikian surat perjanjian ini dibuat dengan sebenarnya oleh masing-masing pihak dengan penuh rasa tanggung jawab dan tanpa adanya paksaan dari pihak manapun.',
          ),
        ),
        pw.Spacer(),
        rowIdentity("Ditandatangani di",
            createdPlace ?? '............................................'),
        rowIdentity(
            "Tanggal",
            createdAt == null
                ? '............................................'
                : Jiffy.parse(createdAt!).format(pattern: "dd MMMM yyyy")),
        pw.SizedBox(height: 15),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              width: 200,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Paragraph(
                      text: "Pihak Pertama",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.SizedBox(height: 90),
                  pw.Paragraph(
                    text: pic?.name == null
                        ? '(............................................)'
                        : "(${pic?.name})".toUpperCase(),
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
                    text: customer?.name == null
                        ? '(............................................)'
                        : "(${customer?.name})".toUpperCase(),
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

  Future<Uint8List> tandaDaftarPdf() async {
    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );
    final font1 = await PdfGoogleFonts.tinosRegular();
    final font2 = await PdfGoogleFonts.tinosBold();
    final image = await imageFromAssetBundle('images/logo.png');
    double lineSpacing = 1.2 * PdfPageFormat.mm;

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
        pw.Center(
          child: pw.Container(
            width: 308,
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
                "SURAT TANDA DAFTAR HAK GUNA PAKAI KIOS",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Center(
          child: pw.Text(
            "Nomor : ${no ?? '.....................................'}",
            style: const pw.TextStyle(fontSize: 12),
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Paragraph(
          text: "Yang bertandatangan dibawah ini :",
          style: const pw.TextStyle(fontSize: 11),
        ),
        rowIdentity("Nama", pic?.name ?? ""),
        rowIdentity("No. KTP", pic?.nik ?? ""),
        rowIdentity(
            "Tanggal Lahir",
            pic?.dateBirth != null
                ? Jiffy.parse(pic!.dateBirth!).format(pattern: "dd MMMM yyyy")
                : ""),
        rowIdentity("No. Telp", pic?.phone ?? ""),
        rowIdentity("Pekerjaan", pic?.job ?? ""),
        rowIdentity("Alamat", pic?.address ?? ""),
        pw.SizedBox(height: 20),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
            text:
                '\t\t\t\t\t\t\t\t\t\t\t\tDalam hal ini bertindak selaku Penanggung Jawab Pengelola ',
            children: [
              pw.TextSpan(
                text: '"Perniagaan Bumi Indah" ',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              const pw.TextSpan(text: 'dengan ini memberikan '),
              pw.TextSpan(
                text: 'HAK GUNA PAKAI KIOS ',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              const pw.TextSpan(text: 'kepada :'),
            ],
          ),
        ),
        pw.SizedBox(height: 20),
        rowIdentity("Nama", customer?.name ?? ""),
        rowIdentity("No. KTP", customer?.nik ?? ""),
        rowIdentity("Alamat", customer?.address ?? ""),
        pw.SizedBox(height: 20),
        pw.Paragraph(
            text: "Data Unit Kios :",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 15),
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
          child: rowIdentity(
            "b.\t\t\t\t\tBlok / Nomor",
            (kios?.block == null || kios?.blockNo == null)
                ? '............................................'
                : '${kios?.block} ${kios?.blockNo}',
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "c.\t\t\t\t\tJumlah Unit Kios",
            (kios?.totalKios == 0 || kios?.totalKios == null)
                ? '............................................'
                : (kios?.totalKios ?? 0).toString(),
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "d.\t\t\t\t\tMasa Berlaku Hak Guna Pakai",
            kios?.endDate != null
                ? Jiffy.parse(kios!.endDate!).format(pattern: "dd MMMM yyyy")
                : '............................................',
            titleWidh: 230,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 18.0 * PdfPageFormat.mm),
          child: rowIdentity(
            "e.\t\t\t\t\tNo. Perjanjian Hak Guna Pakai",
            kios?.noHakGuna ?? '............................................',
            titleWidh: 230,
          ),
        ),
        pw.SizedBox(height: 20),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
            text:
                '\t\t\t\t\t\t\t\t\t\t\t\tDemikian surat tanda daftar Hak Guna pakai kios ini dibuat sebagai bagian yang tidak terpisah dari Perjanjian Kontrak Hak Guna Pakai antara yang bersangkutan dengan pihak penanggung jawab pengelola Perniagaan Bumi Indah.',
          ),
        ),
        pw.Spacer(),
        rowIdentity("Dibuat di",
            createdPlace ?? '............................................'),
        rowIdentity(
            "Tanggal",
            createdAt == null
                ? '............................................'
                : Jiffy.parse(createdAt!).format(pattern: "dd MMMM yyyy")),
        pw.SizedBox(height: 15),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
              style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
              text: 'Penanggung Jawab Pengeloal'),
        ),
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(lineSpacing: lineSpacing, fontSize: 10),
            text: 'Kios ',
            children: [
              pw.TextSpan(
                text: '"Perniagaan Bumi Indah" ',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 90),
        pw.Paragraph(
          text: pic?.name == null
              ? '(............................................)'
              : "(${pic?.name})".toUpperCase(),
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12,
          ),
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
        )
      ],
    ));
    return pdf.save();
  }
}
