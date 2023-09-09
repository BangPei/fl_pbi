import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/currency_formater.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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
    'wide': FormControl<int>(
      value: 0,
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
          title: "date",
          reactiveForm: Common.reactiveDatePicker(
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
          title: "No. KTP",
          reactiveForm: ReactiveTextField(
            formControlName: 'nik',
            onSubmitted: (val) {},
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "No. Telp",
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
        CustomFormField(
          title: "Area",
          reactiveForm: ReactiveTextField(
            formControlName: 'area_name',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Area Perusahaan",
          reactiveForm: ReactiveTextField(
            formControlName: 'area_company',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Luas Area",
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
          title: "Masa Kontrak",
          reactiveForm: ReactiveTextField(
            formControlName: 'periode_rent',
            textAlign: TextAlign.end,
            onSubmitted: (val) {},
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Perpanjangan Kontrak",
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
          title: "Berlaku Kontrak",
          reactiveForm: ReactiveTextField(
            formControlName: 'periode_date',
            onSubmitted: (val) {},
            decoration: TextFormDecoration.box(),
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
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 13),
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           const Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 8),
  //             child: DefaultCardTitle("Surat Sewa Lahan"),
  //           ),
  //           const SizedBox(height: 10),
  //           ReactiveForm(
  //             formGroup: formgroup,
  //             child: Card(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(top: 20.0),
  //                 child: ResponsiveGridRow(
  //                   children: [
  //                     ResponsiveGridCol(
  //                       lg: 12,
  //                       xl: 12,
  //                       md: 12,
  //                       sm: 12,
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(
  //                           left: 16.0,
  //                           right: 16,
  //                           top: 4,
  //                           bottom: 8,
  //                         ),
  //                         child: Center(
  //                           child: SizedBox(
  //                             width: 120,
  //                             child: CustomButton(
  //                               title: const Text('Print'),
  //                               icon: const FaIcon(
  //                                 FontAwesomeIcons.print,
  //                                 color: Colors.white,
  //                                 size: 20,
  //                               ),
  //                               onPressed: () {
  //                                 if (formgroup.valid) {
  //                                   SuratSewaLahan sewaLahan =
  //                                       SuratSewaLahan.fromJson(
  //                                           formgroup.value);
  //                                   context.go("/sewa-lahan/preview",
  //                                       extra: sewaLahan);
  //                                 }
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
