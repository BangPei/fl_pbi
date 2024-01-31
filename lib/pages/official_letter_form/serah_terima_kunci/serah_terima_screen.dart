import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/official_letter_form/serah_terima_kunci/bloc/serah_terima_kunci_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SerahTerimaScreen extends StatefulWidget {
  const SerahTerimaScreen({super.key});

  @override
  State<SerahTerimaScreen> createState() => _SerahTerimaScreenState();
}

class _SerahTerimaScreenState extends State<SerahTerimaScreen> {
  TextEditingController createdDateController = TextEditingController();
  late FocusNode createdDateNode;

  @override
  void initState() {
    context.read<SerahTerimaKunciBloc>().add(const OnInit());
    createdDateNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    createdDateNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SerahTerimaKunciBloc, SerahTerimaKunciState>(
      builder: (context, state) {
        if ((state.isLoading ?? true)) {
          return const Scaffold(body: Center(child: LoadingScreen()));
        }
        return CustomForm(
          title: "Surat Serah Terima Kunci",
          onSubmit: () {
            context.read<SerahTerimaKunciBloc>().add(const OnSubmit());
          },
          action: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              context
                  .read<SerahTerimaKunciBloc>()
                  .add(const OnSubmitTemplate());
            },
          ),
          showCard: false,
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                child: Column(
                  children: [
                    CustomFormField(
                      title: "Ditandatangani di",
                      textForm: TextFormField(
                        decoration: TextFormDecoration.box(),
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedSignPlace(vals));
                        },
                      ),
                    ),
                    CustomFormField(
                      title: "Tanggal Dibuat",
                      textForm: CustomDatePicker(
                        // validator: ValidForm.emptyValue,
                        focusNode: createdDateNode,
                        onCloseDatepicker: (val) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedDate(val: val));
                        },
                        controller: createdDateController,
                      ),
                    ),
                    CustomFormField(
                      title: "Blok & No. Kios",
                      textForm: DropdownWidget<BlockDetail>(
                        isVisible: true,
                        items: state.blockDetails ?? [],
                        itemAsString: (item) => item.name ?? "",
                        selectedItem: state.blockDetail ?? BlockDetail(),
                        onChanged: (BlockDetail? data) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedBlokKios(data!.name!));
                        },
                        child: (item) {
                          return ListTile(
                            title: Text(
                              item.name ?? "",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const FormTitle(title: 'PIHAK PERTAMA'),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                child: Column(
                  children: [
                    CustomFormField(
                      title: "Nama",
                      textForm: TextFormField(
                        initialValue: state.hakGuna?.pic?.name,
                        decoration: TextFormDecoration.box(),
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedNamePihakPertama(vals));
                        },
                      ),
                    ),
                    CustomFormField(
                      title: "No. KTP",
                      textForm: TextFormField(
                        initialValue: state.hakGuna?.pic?.nik,
                        // validator: ValidForm.emptyValue,
                        keyboardType: TextInputType.number,
                        inputFormatters: [Common.ktpFormat],
                        decoration: TextFormDecoration.box(),
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedNikPihakPertama(vals));
                        },
                      ),
                    ),
                    CustomFormField(
                      title: "No.Tlp",
                      textForm: TextFormField(
                        initialValue: state.hakGuna?.pic?.phone,
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedPhonePihakPertama(vals));
                        },
                        decoration: TextFormDecoration.box(),
                      ),
                    ),
                    CustomFormField(
                      title: "Posisi / Jabatan",
                      textForm: TextFormField(
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedPosition(vals));
                        },
                        decoration: TextFormDecoration.box(),
                      ),
                    ),
                    CustomFormField(
                      title: "Alamat",
                      textForm: TextFormField(
                        initialValue: state.hakGuna?.pic?.address,
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                child: Column(
                  children: [
                    CustomFormField(
                      title: "Nama",
                      textForm: TextFormField(
                        decoration: TextFormDecoration.box(),
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedNamePihakKedua(vals));
                        },
                      ),
                    ),
                    CustomFormField(
                      title: "No. KTP",
                      textForm: TextFormField(
                        // validator: ValidForm.emptyValue,
                        keyboardType: TextInputType.number,
                        inputFormatters: [Common.ktpFormat],
                        decoration: TextFormDecoration.box(),
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedNikPihakKedua(vals));
                        },
                      ),
                    ),
                    CustomFormField(
                      title: "No. Tlp",
                      textForm: TextFormField(
                        decoration: TextFormDecoration.box(),
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
                              .add(OnChangedPhonePihakKedua(vals));
                        },
                      ),
                    ),
                    CustomFormField(
                      title: "Alamat",
                      textForm: TextFormField(
                        // validator: ValidForm.emptyValue,
                        onChanged: (vals) {
                          context
                              .read<SerahTerimaKunciBloc>()
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
          ],
        );
      },
    );
  }
}
