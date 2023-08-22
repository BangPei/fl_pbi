import 'package:fl_pbi/widget.dart/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
    ),
    'address': FormControl<String>(
      value: '',
    ),
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DefaultCardTitle("Surat Permohonan"),
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
                                child: SelectableText('Nama'),
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
                                child: SelectableText('NO. KTP'),
                              ),
                              ReactiveTextField(
                                formControlName: 'nik',
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
                                child: SelectableText('No.Tlp'),
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
                                child: SelectableText('Alamat'),
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
                                onPressed: () =>
                                    context.go("/surat-permohonan/preview"),
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
