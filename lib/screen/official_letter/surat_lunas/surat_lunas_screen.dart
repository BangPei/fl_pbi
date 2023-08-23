import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/lunas.dart';
import 'package:fl_pbi/widget.dart/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DefaultCardTitle("Surat Keterangan Lunas"),
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
                                child: SelectableText('Nama Pembuat Surat'),
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
                                child: SelectableText('NO. KTP Pembuat Surat'),
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
                                child: SelectableText('Posisi Pembuat Surat'),
                              ),
                              ReactiveTextField(
                                formControlName: 'position',
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
                                child: SelectableText('No.Tlp Pembuat Surat'),
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
                                child: SelectableText('Blok / NO (Ruko/Kios)'),
                              ),
                              ReactiveTextField(
                                formControlName: 'block',
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
                                child: SelectableText('Tanggal Surat Dibuat'),
                              ),
                              ReactiveDatePicker<DateTime>(
                                formControlName: 'date',
                                builder: (BuildContext context,
                                    ReactiveDatePickerDelegate<dynamic> picker,
                                    Widget? child) {
                                  Widget suffix = InkWell(
                                    onTap: () {
                                      _dateFocusNode.unfocus();
                                      if (formgroup.control('date').value ==
                                          null) {
                                        picker.showPicker();
                                      } else {
                                        picker.control.value = null;
                                        Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {
                                          _dateFocusNode.canRequestFocus = true;
                                        });
                                      }
                                    },
                                    child:
                                        formgroup.control('date').value == null
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
                                      dateTimeFormat:
                                          DateFormat('dd MMMM yyyy'),
                                    ),
                                    formControlName: 'date',
                                    focusNode: _dateFocusNode,
                                    readOnly: true,
                                    decoration: BootstrapInputDecoration(
                                        suffixIcon: suffix),
                                  );
                                },
                                firstDate: DateTime(1900),
                                lastDate: DateTime(3000),
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
                                child: SelectableText('Alamat Pembuat Surat'),
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
                                onPressed: () {
                                  if (formgroup.valid) {
                                    SuratLunas lunas =
                                        SuratLunas.fromJson(formgroup.value);
                                    context.go("/surat-lunas/preview",
                                        extra: lunas);
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
