import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/pages/block/bloc/block_form_bloc.dart';
import 'package:fl_pbi/pages/block/card_block_number.dart';
import 'package:fl_pbi/pages/block/dialog_block_number.dart';
import 'package:fl_pbi/pages/profile/screen/dialog_body.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/empty_card.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockFormScreen extends StatefulWidget {
  final int? id;
  const BlockFormScreen({super.key, this.id});

  @override
  State<BlockFormScreen> createState() => _BlockFormScreenState();
}

class _BlockFormScreenState extends State<BlockFormScreen> {
  @override
  void initState() {
    if (widget.id != null) {
      context.read<BlockFormBloc>().add(OnGetBlock(widget.id!));
    } else {
      context.read<BlockFormBloc>().add(OnResetForm());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlockFormBloc, BlockFormState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Common.modalInfo(
            context,
            title: "Success",
            message: "Berhasil Merubah Data",
            mode: MODE.success,
          );
        }
      },
      child: BlocBuilder<BlockFormBloc, BlockFormState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(body: Center(child: LoadingScreen()));
          }
          return CustomForm(
            title: "Form Blok Kios/Lahan",
            onSubmit: () {
              context.read<BlockFormBloc>().add(OnSubmit());
            },
            showCard: false,
            buttonTitle: "Simpan",
            children: [
              CustomFormField(
                title: "Nama Blok",
                textForm: TextFormField(
                  controller:
                      TextEditingController(text: state.block?.name ?? ""),
                  validator: ValidForm.emptyValue,
                  onChanged: (val) {
                    context.read<BlockFormBloc>().add(OnChangedName(val));
                  },
                  decoration: TextFormDecoration.box(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FormTitle(
                      title: 'Data Kios/Lahan',
                      fontSize: 15,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: DialogBody(
                                numbers: state.block?.numbers,
                                onTap: (e) {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: DialogBlockNumber(
                                          blockName: state.block?.name ?? "",
                                          no: e,
                                          onPress: (no) {
                                            context
                                                .read<BlockFormBloc>()
                                                .add(OnAddNumber(no));
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Tambah"),
                    )
                  ],
                ),
              ),
              (state.block?.numbers ?? []).isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (state.block?.numbers ?? []).map((e) {
                          return CardBlockNumber(
                            number: e,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: DialogBlockNumber(
                                      blockName: state.block?.name ?? "",
                                      no: e,
                                      onPress: (no) {
                                        context
                                            .read<BlockFormBloc>()
                                            .add(OnAddNumber(no));
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }).toList(),
                      ),
                    )
                  : const EmptyCard(),
            ],
          );
        },
      ),
    );
  }
}
