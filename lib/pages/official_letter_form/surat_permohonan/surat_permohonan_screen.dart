import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_permohonan/bloc/permohonan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/widget_file.dart';

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
        context.read<PermohonanBloc>().add(const OnSubmit());
      },
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {
          context.read<PermohonanBloc>().add(const OnSubmitTemplate());
        },
      ),
      children: [
        CustomFormField(
          title: "Nama",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<PermohonanBloc>().add(OnChangedName(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "NO. KTP",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<PermohonanBloc>().add(OnChangedNik(val));
            },
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "NO. Telp",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<PermohonanBloc>().add(OnChangedPhone(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<PermohonanBloc>().add(OnChangedAddress(val));
            },
            decoration: TextFormDecoration.box(),
            maxLines: 3,
            minLines: 3,
          ),
        ),
      ],
    );
  }
}
