import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:flutter/material.dart';

class PerjanjianHakGunaPakai extends StatefulWidget {
  const PerjanjianHakGunaPakai({super.key});

  @override
  State<PerjanjianHakGunaPakai> createState() => _PerjanjianHakGunaPakaiState();
}

class _PerjanjianHakGunaPakaiState extends State<PerjanjianHakGunaPakai> {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Perjanjian Hak Guna Pakai',
      onSubmit: () {
        // context.read<FormulirPendaftaranBloc>().add(const OnSubmit());
      },
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {
          // context.read<FormulirPendaftaranBloc>().add(const OnSubmitTemplate());
        },
      ),
      children: [
        CustomFormField(
          title: "Nama",
          textForm: TextFormField(
            decoration: TextFormDecoration.box(),
            validator: ValidForm.emptyValue,
            onChanged: (vals) {
              // context.read<FormulirPendaftaranBloc>().add(OnNameChanged(vals));
            },
          ),
        ),
        CustomFormField(
          title: "No. KTP",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
            decoration: TextFormDecoration.box(),
            onChanged: (vals) {
              // context.read<FormulirPendaftaranBloc>().add(OnNikChanged(vals));
            },
          ),
        ),
        CustomFormField(
          title: "No.Tlp",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            onChanged: (vals) {
              // context.read<FormulirPendaftaranBloc>().add(OnPhoneChanged(vals));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Blok",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            onChanged: (vals) {
              // context.read<FormulirPendaftaranBloc>().add(OnBlockChanged(vals));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat Pemohon",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            onChanged: (vals) {
              // context
              //     .read<FormulirPendaftaranBloc>()
              //     .add(OnAddressChanged(vals));
            },
            minLines: 3,
            maxLines: 3,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Nama Pengelola",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            onChanged: (vals) {
              // context.read<FormulirPendaftaranBloc>().add(OnPicChanged(vals));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
      ],
    );
  }
}
