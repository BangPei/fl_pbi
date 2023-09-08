import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/lunas.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SuratLunasScreen extends StatefulWidget {
  const SuratLunasScreen({super.key});

  @override
  State<SuratLunasScreen> createState() => _SuratLunasScreenState();
}

class _SuratLunasScreenState extends State<SuratLunasScreen> {
  late FocusNode _dateFocusNode;
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
    return CustomForm(
      title: 'Surat Keterangan Lunas',
      formGroup: formgroup,
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
          title: "Posisi",
          reactiveForm: ReactiveTextField(
            formControlName: 'position',
            onSubmitted: (val) {},
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
          title: "NO. Blok",
          reactiveForm: ReactiveTextField(
            formControlName: 'block',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Tanggal Lunas",
          reactiveForm: ReactiveDatePicker<DateTime>(
            formControlName: 'date',
            builder: (BuildContext context,
                ReactiveDatePickerDelegate<dynamic> picker, Widget? child) {
              Widget suffix = InkWell(
                onTap: () {
                  _dateFocusNode.unfocus();
                  if (formgroup.control('date').value == null) {
                    picker.showPicker();
                  } else {
                    picker.control.value = null;
                    Future.delayed(const Duration(milliseconds: 100), () {
                      _dateFocusNode.canRequestFocus = true;
                    });
                  }
                },
                child: formgroup.control('date').value == null
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
                  if (_dateFocusNode.canRequestFocus) {
                    _dateFocusNode.unfocus();
                    picker.showPicker();
                  }
                },
                valueAccessor: DateTimeValueAccessor(
                  dateTimeFormat: DateFormat('dd MMMM yyyy'),
                ),
                formControlName: 'date',
                focusNode: _dateFocusNode,
                readOnly: true,
                decoration: TextFormDecoration.box(suffixIcon: suffix),
              );
            },
            firstDate: DateTime(1900),
            lastDate: DateTime(3000),
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
      onPrint: () {
        if (formgroup.valid) {
          SuratLunas lunas = SuratLunas.fromJson(formgroup.value);
          // context.pushNamed("preview-permohonan",
          //     queryParameters: permohonan.toStringJson());
          context.pushNamed("preview-pdf", extra: {
            "data": lunas,
            "pdf": lunas.pdf(),
            "title":
                "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
          });
        }
      },
      onDownload: () {
        context.pushNamed("preview-pdf", extra: {
          "data": SuratLunas(),
          "pdf": SuratLunas().pdf(),
          "title":
              "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
        });
      },
    );
  }
}
