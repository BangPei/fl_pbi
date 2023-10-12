import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/tanda_hak_guna/bloc/tanda_hak_guna_bloc.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class TandaHakGunaScreen extends StatefulWidget {
  const TandaHakGunaScreen({super.key});

  @override
  State<TandaHakGunaScreen> createState() => _TandaHakGunaScreenState();
}

class _TandaHakGunaScreenState extends State<TandaHakGunaScreen> {
  TextEditingController createdDateController = TextEditingController();
  FocusNode createdDateNode = FocusNode();
  TextEditingController dateBirthController = TextEditingController();
  FocusNode dateBirthNode = FocusNode();
  TextEditingController validDateController = TextEditingController();
  FocusNode validDateNode = FocusNode();

  @override
  void initState() {
    context.read<TandaHakGunaBloc>().add(const OnInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TandaHakGunaBloc, TandaHakGunaState>(
      listener: (context, state) {
        if (state.hakGuna?.pic?.dateBirth != null) {
          dateBirthController.text = Jiffy.parse(state.hakGuna!.pic!.dateBirth!)
              .format(pattern: "dd MMMM yyyy");
        }
      },
      child: BlocBuilder<TandaHakGunaBloc, TandaHakGunaState>(
          builder: (context, state) {
        return (state.isLoading ?? true)
            ? const Scaffold(body: Center(child: LoadingScreen()))
            : CustomForm(
                title: 'Form Tanda Hak Guna Pakai',
                showCard: false,
                onSubmit: () {
                  context.read<TandaHakGunaBloc>().add(const OnSubmit());
                },
                action: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    context
                        .read<TandaHakGunaBloc>()
                        .add(const OnSubmitTemplate());
                  },
                ),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 5),
                      child: Column(
                        children: [
                          CustomFormField(
                            title: "Nomor Surat",
                            textForm: TextFormField(
                              decoration: TextFormDecoration.box(),
                              validator: ValidForm.emptyValue,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedNomorSurat(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Tempat Dibuat",
                            textForm: TextFormField(
                              decoration: TextFormDecoration.box(),
                              validator: ValidForm.emptyValue,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedTempatDibuat(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Tanggal Dibuat",
                            textForm: CustomDatePicker(
                              validator: ValidForm.emptyValue,
                              focusNode: createdDateNode,
                              onCloseDatepicker: (val) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedTanggalDibuat(val: val));
                              },
                              controller: createdDateController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const FormTitle(title: 'Data Pengelola'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 5),
                      child: Column(
                        children: [
                          CustomFormField(
                            title: "Nama",
                            textForm: TextFormField(
                              decoration: TextFormDecoration.box(),
                              initialValue: state.hakGuna?.pic?.name,
                              validator: ValidForm.emptyValue,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedNamaPihakPertama(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Tanggal Lahir",
                            textForm: CustomDatePicker(
                              validator: ValidForm.emptyValue,
                              focusNode: dateBirthNode,
                              onCloseDatepicker: (val) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedDOBPihakPertama(val: val));
                              },
                              controller: dateBirthController,
                            ),
                          ),
                          CustomFormField(
                            title: "No. KTP",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              keyboardType: TextInputType.number,
                              inputFormatters: [Common.ktpFormat],
                              decoration: TextFormDecoration.box(),
                              initialValue: state.hakGuna?.pic?.nik,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedNikPihakPertama(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "No.Tlp",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              initialValue: state.hakGuna?.pic?.phone,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedPhonePihakPertama(vals));
                              },
                              decoration: TextFormDecoration.box(),
                            ),
                          ),
                          CustomFormField(
                            title: "Posisi / Jabatan",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedJobPihakPertama(vals));
                              },
                              decoration: TextFormDecoration.box(),
                            ),
                          ),
                          CustomFormField(
                            title: "Alamat",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              initialValue: state.hakGuna?.pic?.address,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedAddressPihakPertama(vals));
                              },
                              minLines: 3,
                              maxLines: 3,
                              decoration: TextFormDecoration.box(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const FormTitle(title: 'Data Pembeli / Penyewa'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 5),
                      child: Column(
                        children: [
                          CustomFormField(
                            title: "Nama",
                            textForm: TextFormField(
                              decoration: TextFormDecoration.box(),
                              validator: ValidForm.emptyValue,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedNamePihakKedua(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "No. KTP",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              keyboardType: TextInputType.number,
                              inputFormatters: [Common.ktpFormat],
                              decoration: TextFormDecoration.box(),
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedNikPihakKedua(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Alamat",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedAddressPihakKedua(vals));
                              },
                              minLines: 3,
                              maxLines: 3,
                              decoration: TextFormDecoration.box(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const FormTitle(title: 'Data Kios'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 5),
                      child: Column(
                        children: [
                          CustomFormField(
                            title: "Lokasi Kios",
                            textForm: TextFormField(
                              decoration: TextFormDecoration.box(),
                              validator: ValidForm.emptyValue,
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedLocation(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Blok Kios",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              decoration: TextFormDecoration.box(),
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedBlock(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Nomor Kios",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              decoration: TextFormDecoration.box(),
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedBlockNo(vals));
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Jumlah Kios",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              decoration: TextFormDecoration.box(),
                              onChanged: (vals) {
                                if (vals.isNotEmpty) {
                                  int val = int.parse(vals);
                                  context
                                      .read<TandaHakGunaBloc>()
                                      .add(OnChangedJumlahKios(val));
                                }
                              },
                            ),
                          ),
                          CustomFormField(
                            title: "Masa Berlaku",
                            textForm: CustomDatePicker(
                              validator: ValidForm.emptyValue,
                              focusNode: validDateNode,
                              onCloseDatepicker: (val) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedMasaBerlaku(val: val));
                              },
                              controller: validDateController,
                            ),
                          ),
                          CustomFormField(
                            title: "Nomor Perjanjian Hak Guna Pakai",
                            textForm: TextFormField(
                              validator: ValidForm.emptyValue,
                              decoration: TextFormDecoration.box(),
                              onChanged: (vals) {
                                context
                                    .read<TandaHakGunaBloc>()
                                    .add(OnChangedNoPerjanjian(vals));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
