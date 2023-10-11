import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/perjanjian_hak_guna/bloc/perjanjian_hak_guna_bloc.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class PerjanjianHakGunaPakai extends StatefulWidget {
  const PerjanjianHakGunaPakai({super.key});

  @override
  State<PerjanjianHakGunaPakai> createState() => _PerjanjianHakGunaPakaiState();
}

class _PerjanjianHakGunaPakaiState extends State<PerjanjianHakGunaPakai> {
  TextEditingController createdDateController = TextEditingController();
  FocusNode createdDateNode = FocusNode();
  TextEditingController dateBirthController = TextEditingController();
  FocusNode dateBirthNode = FocusNode();
  TextEditingController validDateController = TextEditingController();
  FocusNode validDateNode = FocusNode();

  @override
  void initState() {
    context.read<PerjanjianHakGunaBloc>().add(const OnInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PerjanjianHakGunaBloc, PerjanjianHakGunaState>(
      listener: (context, state) {
        if (state.hakGuna?.pic?.dateBirth != null) {
          dateBirthController.text = Jiffy.parse(state.hakGuna!.pic!.dateBirth!)
              .format(pattern: "dd MMMM yyyy");
        }
      },
      child: BlocBuilder<PerjanjianHakGunaBloc, PerjanjianHakGunaState>(
        builder: (context, state) {
          return (state.isLoading ?? true)
              ? const Scaffold(body: Center(child: LoadingScreen()))
              : CustomForm(
                  title: 'Form Perjanjian Hak Guna',
                  showCard: false,
                  onSubmit: () {
                    context.read<PerjanjianHakGunaBloc>().add(const OnSubmit());
                  },
                  action: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      context
                          .read<PerjanjianHakGunaBloc>()
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedNoSurat(vals));
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Ditandatangani di",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedSignPlace(vals));
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedDate(val: val));
                                },
                                controller: createdDateController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const FormTitle(title: 'PIHAK PERTAMA'),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 5),
                        child: Column(
                          children: [
                            CustomFormField(
                              title: "Nama",
                              textForm: TextFormField(
                                initialValue: state.hakGuna?.pic?.name,
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedNamePihakPertama(vals));
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedDOBPihakPertama(val: val));
                                },
                                controller: dateBirthController,
                              ),
                            ),
                            CustomFormField(
                              title: "No. KTP",
                              textForm: TextFormField(
                                initialValue: state.hakGuna?.pic?.nik,
                                validator: ValidForm.emptyValue,
                                keyboardType: TextInputType.number,
                                inputFormatters: [Common.ktpFormat],
                                decoration: TextFormDecoration.box(),
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedNikPihakPertama(vals));
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "No.Tlp",
                              textForm: TextFormField(
                                initialValue: state.hakGuna?.pic?.phone,
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedPosition(vals));
                                },
                                decoration: TextFormDecoration.box(),
                              ),
                            ),
                            CustomFormField(
                              title: "Alamat",
                              textForm: TextFormField(
                                initialValue: state.hakGuna?.pic?.address,
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
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
                    const FormTitle(title: 'PIHAK KEDUA'),
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
                                      .read<PerjanjianHakGunaBloc>()
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedNikPihakKedua(vals));
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "No. Tlp",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedPhonePihakKedua(vals));
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Pekerjaaan",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedJobPihakKedua(vals));
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Alamat",
                              textForm: TextFormField(
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedLokasiKios(vals));
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedBlokKios(vals));
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedNoKios(vals));
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Jumlah Kios",
                              textForm: TextFormField(
                                validator: ValidForm.emptyValue,
                                decoration: TextFormDecoration.box(),
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    int jumlah =
                                        int.parse(val.replaceAll(",", ""));
                                    context
                                        .read<PerjanjianHakGunaBloc>()
                                        .add(OnChangedJumlahKios(jumlah));
                                  }
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Luas Kios",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    double luas =
                                        double.parse(val.replaceAll(",", ""));
                                    context
                                        .read<PerjanjianHakGunaBloc>()
                                        .add(OnChangedLuasKios(luas));
                                  }
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Jangka Waktu Hak Guna",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    int periode =
                                        int.parse(val.replaceAll(",", ""));
                                    context
                                        .read<PerjanjianHakGunaBloc>()
                                        .add(OnChangedJangkaWaktu(periode));
                                  }
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Tanda Daftar Hak Guna Perunit",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (vals) {
                                  context
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedTandaHakGuna(vals));
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
                                      .read<PerjanjianHakGunaBloc>()
                                      .add(OnChangedMasaBerlaku(val: val));
                                },
                                controller: validDateController,
                              ),
                            ),
                            CustomFormField(
                              title: "Sewa Bulanan Selama Hak Guna",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    double sewa =
                                        double.parse(val.replaceAll(",", ""));
                                    context
                                        .read<PerjanjianHakGunaBloc>()
                                        .add(OnChangedSewaBulanan(sewa));
                                  }
                                },
                              ),
                            ),
                            CustomFormField(
                              title: "Tagihan Iuran Pemakaian Listrik",
                              textForm: TextFormField(
                                decoration: TextFormDecoration.box(),
                                validator: ValidForm.emptyValue,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    double tagihan =
                                        double.parse(val.replaceAll(",", ""));
                                    context
                                        .read<PerjanjianHakGunaBloc>()
                                        .add(OnChangedTagihanListrik(tagihan));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
