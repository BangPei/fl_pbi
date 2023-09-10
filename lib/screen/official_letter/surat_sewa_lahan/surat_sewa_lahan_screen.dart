import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/currency_formater.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SuratSewaLahanScreen extends StatefulWidget {
  const SuratSewaLahanScreen({super.key});

  @override
  State<SuratSewaLahanScreen> createState() => _SuratSewaLahanScreenState();
}

class _SuratSewaLahanScreenState extends State<SuratSewaLahanScreen> {
  late FocusNode dateFocusNode;
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
    'owner_name': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'area_name': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'area_company': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'wide': FormControl<String>(
      value: "",
      validators: [Validators.required],
    ),
    'extra_time': FormControl<int>(
      value: 0,
      validators: [Validators.required],
    ),
    'periode_rent': FormControl<int>(
      value: 0,
      validators: [Validators.required],
    ),
    'date': FormControl<DateTime>(
      value: null,
      validators: [Validators.required],
    ),
    'periode_date': FormControl<DateTime>(
      value: null,
      validators: [Validators.required],
    ),
  });

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
      title: 'Surat Sewa Lahan',
      formGroup: formgroup,
      children: [
        CustomFormField(
          title: "Tanggal Perjanjian",
          reactiveForm: CustomDatePicker(
            focusNode: dateFocusNode,
            formGroup: formgroup,
            formControlName: "date",
          ),
        ),
        CustomFormField(
          title: "Pihak Pertama",
          reactiveForm: ReactiveTextField(
            formControlName: 'owner_name',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pihak Kedua",
          reactiveForm: ReactiveTextField(
            formControlName: 'name',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "No. KTP Pihak Kedua",
          reactiveForm: ReactiveTextField(
            formControlName: 'nik',
            onSubmitted: (val) {},
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "No.Tlp Pihak Kedua",
          reactiveForm: ReactiveTextField(
            formControlName: 'phone',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat Pihak Kedua",
          reactiveForm: ReactiveTextField(
            maxLines: 3,
            minLines: 3,
            formControlName: 'address',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Area Lahan",
          reactiveForm: ReactiveTextField(
            formControlName: 'area_name',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pemilik Area",
          reactiveForm: ReactiveTextField(
            formControlName: 'area_company',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Luas Area (Meter persegi)",
          reactiveForm: ReactiveTextField(
            formControlName: 'wide',
            onSubmitted: (val) {},
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Durasi Sewa Lahan (Tahun)",
          reactiveForm: ReactiveTextField(
            formControlName: 'periode_rent',
            textAlign: TextAlign.end,
            onSubmitted: (val) {
              DateTime? commitDate = formgroup.control('date').value;
              if (commitDate != null) {
                int year = formgroup.control('periode_rent').value;
                var newDate = Jiffy.parseFromDateTime(commitDate)
                    .add(years: year)
                    .dateTime;
                formgroup.control('periode_date').value = newDate;
                setState(() {});
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Durasi Perpanjangan (Tahun)",
          reactiveForm: ReactiveTextField(
            formControlName: 'extra_time',
            onSubmitted: (val) {},
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
          reactiveForm: ReactiveTextField(
            formControlName: 'periode_date',
            readOnly: true,
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
            valueAccessor: DateTimeValueAccessor(
              dateTimeFormat: DateFormat('dd MMMM yyyy'),
            ),
          ),
        ),
      ],
      onPrint: () {
        if (formgroup.valid) {
          SuratSewaLahan sewaLahan = SuratSewaLahan.fromJson(formgroup.value);
          context.pushNamed("preview-pdf", extra: {
            "data": sewaLahan,
            "pdf": sewaLahan.pdf(),
            "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
          });
        }
      },
      onDownload: () {
        context.pushNamed("preview-pdf", extra: {
          "data": SuratSewaLahan(),
          "pdf": SuratSewaLahan().pdf(),
          "title": "Surat Sewa Lahan${DateTime.now().millisecond.toString()}"
        });
      },
    );
  }
}
