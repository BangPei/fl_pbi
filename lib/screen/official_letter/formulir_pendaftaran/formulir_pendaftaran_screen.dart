import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/pendaftaran.dart';
import 'package:fl_pbi/widget.dart/card_template.dart';
import 'package:fl_pbi/widget.dart/custom_Botton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_grid/responsive_grid.dart';

class FormulirPendaftaranScreen extends StatefulWidget {
  const FormulirPendaftaranScreen({super.key});

  @override
  State<FormulirPendaftaranScreen> createState() =>
      _FormulirPendaftaranScreenState();
}

class _FormulirPendaftaranScreenState extends State<FormulirPendaftaranScreen> {
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
    'pic': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'block': FormControl<String>(
      value: '',
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
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DefaultCardTitle("Formulir Pendaftaran"),
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
                          child: ReactiveTextField(
                            formControlName: 'name',
                            onSubmitted: (val) {},
                            decoration: TextFormDecoration.box(),
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
                          child: ReactiveTextField(
                            formControlName: 'nik',
                            onSubmitted: (val) {},
                            inputFormatters: [Common.ktpFormat],
                            decoration: TextFormDecoration.box(),
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
                          child: ReactiveTextField(
                            formControlName: 'phone',
                            onSubmitted: (val) {},
                            decoration: TextFormDecoration.box(),
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
                          child: ReactiveTextField(
                            formControlName: 'block',
                            onSubmitted: (val) {},
                            decoration: TextFormDecoration.box(),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 8,
                        xl: 8,
                        md: 8,
                        sm: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: ReactiveTextField(
                            formControlName: 'pic',
                            onSubmitted: (val) {},
                            decoration: TextFormDecoration.box(),
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
                          child: ReactiveTextField(
                            maxLines: 3,
                            minLines: 3,
                            formControlName: 'address',
                            onSubmitted: (val) {},
                            decoration: TextFormDecoration.box(),
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
                              child: CustomButton(
                                title: const Text('Print'),
                                icon: const FaIcon(
                                  FontAwesomeIcons.print,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  if (formgroup.valid) {
                                    Pendaftaran pendaftaran =
                                        Pendaftaran.fromJson(formgroup.value);
                                    context.go("/formulir-pendaftaran/preview",
                                        extra: pendaftaran);
                                  }
                                },
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
