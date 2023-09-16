import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/permohonan.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuratPermohonanScreen extends StatefulWidget {
  const SuratPermohonanScreen({super.key});

  @override
  State<SuratPermohonanScreen> createState() => _SuratPermohonanScreenState();
}

class _SuratPermohonanScreenState extends State<SuratPermohonanScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Surat Permohonan',
      onSubmit: () {
        // SuratPermohonan permohonan =
        //     SuratPermohonan.fromJson(formgroup.value);
        // context.pushNamed("preview-pdf", extra: {
        //   "data": permohonan,
        //   "pdf": permohonan.pdf(),
        //   "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
        // });
      },
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {
          context.pushNamed("preview-pdf", extra: {
            "data": SuratPermohonan(),
            "pdf": SuratPermohonan().pdf(),
            "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
          });
        },
      ),
      children: [
        CustomFormField(
          title: "Nama",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "NO. KTP",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "NO. Telp",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            decoration: TextFormDecoration.box(),
            maxLines: 3,
            minLines: 3,
          ),
        ),
      ],
    );
  }
}
