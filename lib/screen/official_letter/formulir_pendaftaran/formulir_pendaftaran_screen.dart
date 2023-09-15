import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/pendaftaran.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormulirPendaftaranScreen extends StatefulWidget {
  const FormulirPendaftaranScreen({super.key});

  @override
  State<FormulirPendaftaranScreen> createState() =>
      _FormulirPendaftaranScreenState();
}

class _FormulirPendaftaranScreenState extends State<FormulirPendaftaranScreen> {
  @override
  void initState() {
    // Session.get("fullName").then((value) {
    //   formgroup.control('pic').value = value;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Surat Pendaftaran',
      onSubmit: () {
        // Pendaftaran pendaftaran = Pendaftaran.fromJson(formgroup.value);
        // context.pushNamed("preview-pdf", extra: {
        //   "data": pendaftaran,
        //   "pdf": pendaftaran.pdf(),
        //   "title":
        //       "Surat Pendaftaran ${DateTime.now().millisecond.toString()}"
        // });
      },
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {
          context.pushNamed("preview-pdf", extra: {
            "data": Pendaftaran(),
            "pdf": Pendaftaran().pdf(),
            "title": "Surat Pendaftaran${DateTime.now().millisecond.toString()}"
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
          title: "No. KTP",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "No.Tlp",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Blok",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat Pemohon",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            minLines: 3,
            maxLines: 3,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Nama Pengelola",
          textForm: TextFormField(
            // initialValue: state.profile?.gendre,
            decoration: TextFormDecoration.box(),
          ),
        ),
      ],
    );
  }
}
