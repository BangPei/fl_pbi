import 'dart:convert';
import 'dart:io';

import 'package:fl_pbi/models/hak_guna.dart';
import 'package:fl_pbi/models/pic.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Common {
  Common._();

  static String imageLogo = 'images/logo.png';
  static String imageDollar = 'images/OIP.png';
  static String imageProfile = 'images/profile.png';
  static String imageHome = 'images/home.png';
  static String imageEaten = 'images/eaten.png';
  static String imageBurned = 'images/burned.png';
  static String imageBuilding = 'images/building.png';
  static MaskTextInputFormatter ktpFormat = MaskTextInputFormatter(
    mask: '##.####.######.####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );
  static final oCcy = NumberFormat("#,###", "en_US");

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
                crossAxisAlignment: pw.CrossAxisAlignment.center,
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
                    "Jl. Bumi Indah Raya Ruko Naura Blok NR No. 19, Kel. Sukamantri\nKec. PasarKemis 15560",
                    textAlign: pw.TextAlign.center,
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
      {String? message, required String title, Icon? icon, MODE? mode}) {
    showDialog(
      context: context,
      builder: (__) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Divider(height: 2, thickness: 3),
                icon ??
                    FaIcon(
                      mode == MODE.success
                          ? FontAwesomeIcons.circleCheck
                          : FontAwesomeIcons.circleXmark,
                      color: mode == MODE.success ? Colors.green : Colors.red,
                      size: 50,
                    ),
                Text(
                  message ?? "Message",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mode == MODE.success ? Colors.green : Colors.red,
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

  static Future<Profile> getProfileSession(String strProfile) async {
    // Future.delayed(const Duration(seconds: 1));
    Profile profile = Profile.fromJson(jsonDecode(strProfile));
    return profile;
  }

  static Future<HakGuna?> getHakGuna(Profile profile) async {
    // Future.delayed(const Duration(seconds: 2));
    HakGuna hakGuna = HakGuna();
    Pic pic = hakGuna.pic ?? Pic();
    pic.name = profile.fullName;
    pic.address = profile.currentAddress;
    pic.dateBirth = profile.birthDate;
    pic.nik = profile.identity?.idNumber;
    pic.phone = profile.phone;
    hakGuna.pic = pic;
    return hakGuna;
  }

  static dialogInOutCome(BuildContext context,
      {Function? onTapIn, Function? onTapOut}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return Dialog(
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pilih Transaksi',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 19),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              FontAwesomeIcons.xmark,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ButtonTransaction(
                          title: "Uang Masuk",
                          backgroundColor:
                              const Color.fromARGB(255, 154, 11, 211)
                                  .withOpacity(0.7),
                          onTap: () {
                            Navigator.pop(ctx, true);
                            onTapIn == null ? null : onTapIn();
                          },
                        ),
                        const SizedBox(width: 10),
                        ButtonTransaction(
                          title: "Uang Keluar",
                          backgroundColor:
                              const Color.fromARGB(255, 221, 13, 31)
                                  .withOpacity(0.7),
                          onTap: () {
                            Navigator.pop(ctx, true);
                            onTapOut == null ? null : onTapOut();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static modalConfirm(
    BuildContext context, {
    String? textAlert,
    Function? onCancel,
    Function? onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(textAlert ?? 'Transaksi akan dihapus, Yakin?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                onCancel == null ? null : onCancel();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                onConfirm == null ? null : onConfirm();
              },
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
    return confirmed;
  }

  static yearPicker({
    required BuildContext context,
    required Function(DateTime) onTap,
    int? selecteYear,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              selectedDate: DateTime(selecteYear ?? DateTime.now().year),
              onChanged: (DateTime dateTime) {
                onTap(dateTime);
                Navigator.pop(ctx);
              },
            ),
          ),
        );
      },
    );
  }

  static pickPicture(SOURCE source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source:
          source == SOURCE.camera ? ImageSource.camera : ImageSource.gallery,
    );
    if (photo != null) {
      String path = photo.path;
      var result = await FlutterImageCompress.compressWithFile(
        File(path).absolute.path,
        minWidth: 1000,
        minHeight: 500,
        quality: 94,
        // rotate: 90,
      );
      return base64Encode(result as List<int>);
    } else {
      // ignore: avoid_print
      print("err");
    }
  }
}

enum MODE { success, error }

enum SOURCE { camera, galery }
