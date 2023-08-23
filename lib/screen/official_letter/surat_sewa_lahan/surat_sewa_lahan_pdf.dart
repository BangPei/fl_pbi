import 'dart:typed_data';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class SuratSewaLahanPDF extends StatefulWidget {
  final SuratSewaLahan? data;
  const SuratSewaLahanPDF({super.key, this.data});

  @override
  State<SuratSewaLahanPDF> createState() => _SuratSewaLahanPDFState();
}

class _SuratSewaLahanPDFState extends State<SuratSewaLahanPDF> {
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
        pdfFileName:
            "Surat Sewa Lahan ${DateTime.now().millisecond.toString()}",
        // actions: actions,
        // onPrinted: _showPrintedToast,
        // onShared: _showSharedToast,
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
    String day = widget.data?.date == null
        ? '............'
        : Jiffy.parse(widget.data!.date!, pattern: "dd MMMM yyyy")
            .format(pattern: 'EEEE');
    String date = widget.data?.date == null
        ? '........'
        : Jiffy.parse(widget.data!.date!, pattern: "dd MMMM yyyy")
            .format(pattern: 'd');
    String month = widget.data?.date == null
        ? '........'
        : Jiffy.parse(widget.data!.date!, pattern: "dd MMMM yyyy")
            .format(pattern: 'MMMM');
    String year = widget.data?.date == null
        ? '........'
        : Jiffy.parse(widget.data!.date!, pattern: "dd MMMM yyyy")
            .format(pattern: 'yyyy');

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
            "PERJANJIAN SEWA LAHAN",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.Center(
          child: pw.Text(
            (widget.data?.areaCompany ?? "").toUpperCase(),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        pw.SizedBox(height: 25),
        pw.Paragraph(
          text:
              "Pada hari ini $day Tanggal $date Bulan $month Tahun $year telah ditandatangani perjanjian pemakaian lahan untuk tempat usaha oleh dan dengan :",
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
              text:
                  '${widget.data?.ownerName} , Mewakili Perniagaan Bumi Indah yang beralamat di Jl Bumi Indah Raya Kel. Sukamantri Kec. Pasarkemis 15560. Dalam hal ini bertindak untuk dan atas nama ${widget.data?.areaCompany} sebagai ',
              children: [
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
              rowIdentity("Nama", widget.data?.name ?? ""),
              rowIdentity("No. KTP", widget.data?.nik ?? ""),
              rowIdentity("No. Telp", widget.data?.phone ?? ""),
              rowIdentity("Alamat", widget.data?.address ?? ""),
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
                      'dengan luas lahan (+-) ${widget.data?.wide} m2 yang terletak di Perumahan Bumi Indah Area ${widget.data?.areaName} milik ${widget.data?.areaCompany}.',
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
                  text: "kuliner.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        lineWithNumber(
          textNum: "3. ",
          child: pw.Text(
            "Ijin pemanfaatan lahan kosong tersebut selama ${widget.data?.periodeRent} tahun, sampai dengan ${widget.data?.periodeDate}.",
          ),
        ),
        lineWithNumber(
          textNum: "4. ",
          child: pw.Text(
            "Adapun untuk perpanjangan kontrak dan laporan administrasi per ${widget.data?.extraTime ?? '........................'} tahun.",
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
                      text: widget.data?.areaCompany ?? "",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      margin: const pw.EdgeInsets.only(
                          bottom: 3.0 * PdfPageFormat.mm)),
                  pw.SizedBox(height: 90),
                  pw.Paragraph(
                    text: "(${widget.data?.ownerName})".toUpperCase(),
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
                    text: "(${widget.data?.name})".toUpperCase(),
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
}
