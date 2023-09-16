import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/currency_formater.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SuratSewaLahanScreen extends StatefulWidget {
  const SuratSewaLahanScreen({super.key});

  @override
  State<SuratSewaLahanScreen> createState() => _SuratSewaLahanScreenState();
}

class _SuratSewaLahanScreenState extends State<SuratSewaLahanScreen> {
  late FocusNode dateFocusNode;
  @override
  void initState() {
    dateFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Surat Sewa Lahan',
      onSubmit: () {
        // SuratSewaLahan sewaLahan = SuratSewaLahan.fromJson(formgroup.value);
        // context.pushNamed("preview-pdf", extra: {
        //   "data": sewaLahan,
        //   "pdf": sewaLahan.pdf(),
        //   "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
        // });
      },
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {
          context.pushNamed("preview-pdf", extra: {
            "data": SuratSewaLahan(),
            "pdf": SuratSewaLahan().pdf(),
            "title": "Surat Sewa Lahan${DateTime.now().millisecond.toString()}"
          });
        },
      ),
      children: [
        // CustomFormField(
        //   title: "Tanggal Perjanjian",
        //   reactiveForm: CustomDatePicker(
        //     focusNode: dateFocusNode,
        //     formGroup: formgroup,
        //     formControlName: "date",
        //     onCloseDatepicker: (val) => periodeDate(),
        //   ),
        // ),
        CustomFormField(
          title: "Pihak Pertama",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pihak Kedua",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "No. KTP Pihak Kedua",
          textForm: TextFormField(
            // initialValue: state.profile?.identity?.idNumber,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
          ),
        ),
        CustomFormField(
          title: "No.Tlp Pihak Kedua",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat Pihak Kedua",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            maxLines: 3,
            minLines: 3,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Area Lahan",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pemilik Area",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Luas Area (Meter persegi)",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
          ),
        ),
        CustomFormField(
          title: "Durasi Sewa Lahan (Tahun)",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            textAlign: TextAlign.end,
            // onSubmitted: (val) => periodeDate(),
            onChanged: (val) => periodeDate(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Durasi Perpanjangan (Tahun)",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            onChanged: (val) {},
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Periode Sewa Lahan",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            readOnly: true,
            decoration: TextFormDecoration.box(),
          ),
        ),
      ],
    );
  }

  void periodeDate() {
    // DateTime? commitDate = formgroup.control('date').value;
    // int year = formgroup.control('periodeRent').value ?? 0;
    // if (commitDate != null && year > 0) {
    //   var newDate =
    //       Jiffy.parseFromDateTime(commitDate).add(years: year).dateTime;
    //   formgroup.control('periodeDate').value = newDate;
    //   setState(() {});
    // }
  }
}
