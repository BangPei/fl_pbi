import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/currency_formater.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:fl_pbi/widget.dart/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DefaultCardTitle("Surat Sewa Lahan"),
            ),
            const SizedBox(height: 10),
            ReactiveForm(
              formGroup: formgroup,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        lg: 6,
                        xl: 6,
                        md: 6,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 2,
                          ),
                          child: Common.reactiveDatePicker(
                            labelText: "Tanggal Perjanjian",
                            focusNode: dateFocusNode,
                            formGroup: formgroup,
                            formControlName: "date",
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 6,
                        xl: 6,
                        md: 6,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Pihak Pertama'),
                              ),
                              ReactiveTextField(
                                formControlName: 'owner_name',
                                onSubmitted: (val) {},
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Pihak Kedua'),
                              ),
                              ReactiveTextField(
                                formControlName: 'name',
                                onSubmitted: (val) {},
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('No. KTP Pihak Kedua'),
                              ),
                              ReactiveTextField(
                                formControlName: 'nik',
                                onSubmitted: (val) {},
                                inputFormatters: [Common.ktpFormat],
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('No.Tlp Pihak Kedua'),
                              ),
                              ReactiveTextField(
                                formControlName: 'phone',
                                onSubmitted: (val) {},
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        xl: 12,
                        md: 12,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Alamat Pihak Kedua'),
                              ),
                              ReactiveTextField(
                                maxLines: 3,
                                minLines: 3,
                                formControlName: 'address',
                                onSubmitted: (val) {},
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Area Lahan'),
                              ),
                              ReactiveTextField(
                                formControlName: 'area_name',
                                onSubmitted: (val) {},
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Pemilik Area'),
                              ),
                              ReactiveTextField(
                                formControlName: 'area_company',
                                onSubmitted: (val) {},
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Luas Area'),
                              ),
                              ReactiveTextField(
                                formControlName: 'wide',
                                onSubmitted: (val) {},
                                textAlign: TextAlign.end,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyInputFormatter(),
                                ],
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Durasi Sewa Lahan'),
                              ),
                              ReactiveTextField(
                                formControlName: 'periode_rent',
                                textAlign: TextAlign.end,
                                onSubmitted: (val) {},
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyInputFormatter(),
                                ],
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Durasi Perpanjangan'),
                              ),
                              ReactiveTextField(
                                formControlName: 'extra_time',
                                onSubmitted: (val) {},
                                textAlign: TextAlign.end,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyInputFormatter(),
                                ],
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xl: 4,
                        md: 4,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: BootstrapFormGroup(
                            children: [
                              const BootstrapLabelText(
                                child: SelectableText('Periode Sewa Lahan'),
                              ),
                              ReactiveTextField(
                                formControlName: 'periode_date',
                                onSubmitted: (val) {},
                                decoration: const BootstrapInputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        xl: 12,
                        md: 12,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16,
                            top: 4,
                            bottom: 8,
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 120,
                              child: BootstrapButton(
                                size: BootstrapButtonSize.defaults,
                                type: BootstrapButtonType.primary,
                                onPressed: () {
                                  if (formgroup.valid) {
                                    SuratSewaLahan sewaLahan =
                                        SuratSewaLahan.fromJson(
                                            formgroup.value);
                                    context.go("/sewa-lahan/preview",
                                        extra: sewaLahan);
                                  }
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.print,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text('Print'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
