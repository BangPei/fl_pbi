import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/models/number.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/profile/bloc/number_bloc.dart';
import 'package:fl_pbi/widget.dart/custom_badge.dart';
import 'package:fl_pbi/widget.dart/custom_botton.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogBody extends StatefulWidget {
  final Function(Number)? onTap;
  final List<BlockDetail>? blockDetails;
  const DialogBody({super.key, this.onTap, this.blockDetails});
  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<NumberBloc>().add(const GetNumbers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 20),
      child: BlocListener<NumberBloc, NumberState>(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: CustomFormField(
                  title: "Masukan Nomor Baru",
                  textForm: TextFormField(
                    // initialValue: (state.park?.amount ?? 0).toString(),
                    validator: ValidForm.emptyValue,
                    decoration: TextFormDecoration.box(),
                    onChanged: (val) =>
                        context.read<NumberBloc>().add(OnChangedNumber(val)),
                  ),
                ),
              ),
              CustomButton(
                backgroundColor: Colors.blue,
                title: const Text("Simpan"),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    context.read<NumberBloc>().add(const OnSubmit());
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Text(
                  "Daftar Nomor Blok",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: BlocBuilder<NumberBloc, NumberState>(
                  builder: (context, state) {
                    return state.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : (state.numbers ?? []).isEmpty
                            ? Card(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child:
                                        Center(child: Text("Tidak ada data")),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Wrap(
                                    children: (state.numbers ?? []).map((e) {
                                      bool isExist = (widget.blockDetails ?? [])
                                          .any((f) => f.number?.id == e.id);
                                      return GestureDetector(
                                        onTap: () {
                                          widget.onTap == null
                                              ? null
                                              : isExist
                                                  ? null
                                                  : widget.onTap!(e);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CustomeBadge(
                                            text: e.name ?? "",
                                            width: 35,
                                            height: 35,
                                            backgroundColor: isExist
                                                ? AppTheme.deactivatedText
                                                    .withOpacity(0.2)
                                                : null,
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: AppTheme.nearlyBlue,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
