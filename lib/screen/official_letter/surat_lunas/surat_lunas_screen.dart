import 'dart:convert';

import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/lunas.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SuratLunasScreen extends StatefulWidget {
  const SuratLunasScreen({super.key});

  @override
  State<SuratLunasScreen> createState() => _SuratLunasScreenState();
}

class _SuratLunasScreenState extends State<SuratLunasScreen> {
  late FocusNode _dateFocusNode;
  Profile? profile;
  bool isLoading = false;
  final FormGroup formgroup = FormGroup({
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
    'position': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'block': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'date': FormControl<DateTime>(
      value: null,
      validators: [Validators.required],
    ),
  });
  @override
  void initState() {
    isLoading = true;
    Session.get("profile").then((value) {
      profile = Profile.fromJson(jsonDecode(value ?? "{}"));
      formgroup.control('name').value = profile?.fullName ?? "";
      formgroup.control('phone').value = profile?.phone ?? "";
      formgroup.control('address').value = profile?.currentAddress ?? "";
      isLoading = false;
      setState(() {});
    });
    _dateFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(body: Center(child: LoadingScreen()))
        : CustomForm(
            title: 'Form Surat Keterangan Lunas',
            formGroup: formgroup,
            onSubmit: () {
              if (formgroup.valid) {
                SuratLunas lunas = SuratLunas.fromJson(formgroup.value);
                context.pushNamed("preview-pdf", extra: {
                  "data": lunas,
                  "pdf": lunas.pdf(),
                  "title":
                      "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
                });
              } else {
                formgroup.markAllAsTouched();
              }
            },
            action: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                context.pushNamed("preview-pdf", extra: {
                  "data": SuratLunas(),
                  "pdf": SuratLunas().pdf(),
                  "title":
                      "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
                });
              },
            ),
            children: [
              CustomFormField(
                title: "Nama Pengelola",
                reactiveForm: ReactiveTextField(
                  formControlName: 'name',
                  onChanged: (val) {},
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "No. KTP Pengelola",
                reactiveForm: ReactiveTextField(
                  formControlName: 'nik',
                  onSubmitted: (val) {},
                  keyboardType: TextInputType.number,
                  inputFormatters: [Common.ktpFormat],
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "Posisi / Jabatan Pengelola",
                reactiveForm: ReactiveTextField(
                  formControlName: 'position',
                  onSubmitted: (val) {},
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "No. Telp Pengelola",
                reactiveForm: ReactiveTextField(
                  formControlName: 'phone',
                  onSubmitted: (val) {},
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "Alamat Pengelola",
                reactiveForm: ReactiveTextField(
                  maxLines: 3,
                  minLines: 3,
                  formControlName: 'address',
                  onSubmitted: (val) {},
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "No. Blok",
                reactiveForm: ReactiveTextField(
                  formControlName: 'block',
                  onSubmitted: (val) {},
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "Tanggal Lunas",
                reactiveForm: CustomDatePicker(
                  focusNode: _dateFocusNode,
                  formGroup: formgroup,
                  formControlName: "date",
                  onCloseDatepicker: (val) {},
                ),
              ),
            ],
          );
  }
}
