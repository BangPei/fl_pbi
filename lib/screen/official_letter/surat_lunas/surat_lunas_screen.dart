import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/bloc/surat_lunas_bloc.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuratLunasScreen extends StatefulWidget {
  const SuratLunasScreen({super.key});

  @override
  State<SuratLunasScreen> createState() => _SuratLunasScreenState();
}

class _SuratLunasScreenState extends State<SuratLunasScreen> {
  late FocusNode _dateFocusNode;
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    _dateFocusNode = FocusNode();
    context.read<SuratLunasBloc>().add(const OnInitLunas());
    super.initState();
  }

  @override
  void dispose() {
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuratLunasBloc, SuratLunasState>(
      builder: (context, state) {
        return state.isLoading
            ? const Scaffold(body: Center(child: LoadingScreen()))
            : CustomForm(
                title: 'Form Surat Keterangan Lunas',
                onSubmit: () {
                  context.read<SuratLunasBloc>().add(const OnSubmit());
                },
                action: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    context
                        .read<SuratLunasBloc>()
                        .add(const OnSubmitTemplate());
                  },
                ),
                children: [
                  CustomFormField(
                    title: "Nama Pengelola",
                    textForm: TextFormField(
                      // validator: ValidForm.emptyValue,
                      initialValue: state.lunas?.name,
                      onChanged: (val) {
                        context.read<SuratLunasBloc>().add(OnNameChanged(val));
                      },
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "No. KTP Pengelola",
                    textForm: TextFormField(
                      // validator: ValidForm.emptyValue,
                      initialValue: state.lunas?.nik,
                      onChanged: (val) {
                        context.read<SuratLunasBloc>().add(OnNikChanged(val));
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [Common.ktpFormat],
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "Posisi / Jabatan Pengelola",
                    textForm: TextFormField(
                      // validator: ValidForm.emptyValue,
                      initialValue: state.lunas?.position,
                      onChanged: (val) {
                        context
                            .read<SuratLunasBloc>()
                            .add(OnPositionChanged(val));
                      },
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "No. Telp Pengelola",
                    textForm: TextFormField(
                      // validator: ValidForm.emptyValue,
                      initialValue: state.lunas?.phone,
                      onChanged: (val) {
                        context.read<SuratLunasBloc>().add(OnPhoneChanged(val));
                      },
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "Alamat Pengelola",
                    textForm: TextFormField(
                      // validator: ValidForm.emptyValue,
                      initialValue: state.lunas?.address,
                      onChanged: (val) {
                        context
                            .read<SuratLunasBloc>()
                            .add(OnAddressChanged(val));
                      },
                      decoration: TextFormDecoration.box(),
                      maxLines: 3,
                      minLines: 3,
                    ),
                  ),
                  CustomFormField(
                    title: "No. Blok",
                    textForm: TextFormField(
                      // validator: ValidForm.emptyValue,
                      initialValue: state.lunas?.block,
                      onChanged: (val) {
                        context.read<SuratLunasBloc>().add(OnBlockChanged(val));
                      },
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "Tanggal Lunas",
                    textForm: CustomDatePicker(
                      // validator: ValidForm.emptyValue,
                      focusNode: _dateFocusNode,
                      onCloseDatepicker: (val) {
                        context
                            .read<SuratLunasBloc>()
                            .add(OnDateChanged(val: val));
                      },
                      controller: dateController,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
