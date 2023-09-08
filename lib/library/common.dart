import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:reactive_forms/reactive_forms.dart';

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

  static Widget reactiveDatePicker({
    required FocusNode focusNode,
    required FormGroup formGroup,
    required String formControlName,
    required String labelText,
  }) {
    return ReactiveDatePicker<DateTime>(
      formControlName: formControlName,
      builder: (BuildContext context,
          ReactiveDatePickerDelegate<dynamic> picker, Widget? child) {
        Widget suffix = InkWell(
          onTap: () {
            focusNode.unfocus();
            if (formGroup.control(formControlName).value == null) {
              picker.showPicker();
            } else {
              picker.control.value = null;
              Future.delayed(const Duration(milliseconds: 100), () {
                focusNode.canRequestFocus = true;
              });
            }
          },
          child: formGroup.control('date').value == null
              ? const Icon(
                  FontAwesomeIcons.calendarCheck,
                  color: Colors.blue,
                )
              : const Icon(
                  FontAwesomeIcons.xmark,
                  color: Colors.red,
                ),
        );
        return ReactiveTextField(
          onTap: (_) {
            if (focusNode.canRequestFocus) {
              focusNode.unfocus();
              picker.showPicker();
            }
          },
          valueAccessor: DateTimeValueAccessor(
            dateTimeFormat: DateFormat('dd MMMM yyyy'),
          ),
          formControlName: 'date',
          focusNode: focusNode,
          readOnly: true,
          decoration: TextFormDecoration.box(suffixIcon: suffix),
        );
      },
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
  }
}
