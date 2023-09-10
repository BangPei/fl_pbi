import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/permohonan.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SuratPermohonanScreen extends StatefulWidget {
  const SuratPermohonanScreen({super.key});

  @override
  State<SuratPermohonanScreen> createState() => _SuratPermohonanScreenState();
}

class _SuratPermohonanScreenState extends State<SuratPermohonanScreen> {
  final formgroup = FormGroup({
    'name': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'phone': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'nik': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'address': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
  });
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Surat Permohonan',
      formGroup: formgroup,
      onSubmit: () {
        if (formgroup.valid) {
          SuratPermohonan permohonan =
              SuratPermohonan.fromJson(formgroup.value);
          context.pushNamed("preview-pdf", extra: {
            "data": permohonan,
            "pdf": permohonan.pdf(),
            "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
          });
        }
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
          reactiveForm: ReactiveTextField(
            formControlName: 'name',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "NO. KTP",
          reactiveForm: ReactiveTextField(
            formControlName: 'nik',
            onSubmitted: (val) {},
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "NO. Telp",
          reactiveForm: ReactiveTextField(
            formControlName: 'phone',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat",
          reactiveForm: ReactiveTextField(
            maxLines: 3,
            minLines: 3,
            formControlName: 'address',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
      ],
    );
  }
}
