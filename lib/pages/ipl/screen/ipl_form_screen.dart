import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/ipl/bloc/form_ipl_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

class IPLFormScreen extends StatefulWidget {
  final int type;
  final int? id;
  final int? year;
  final String? blockCode;
  final String? month;
  const IPLFormScreen(
      {super.key,
      this.id,
      required this.type,
      this.blockCode,
      this.year,
      this.month});

  @override
  State<IPLFormScreen> createState() => _IPLFormScreenState();
}

class _IPLFormScreenState extends State<IPLFormScreen> {
  late FocusNode dateFocusNode;
  String? evidentBase64, title;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  late bool isIn;

  @override
  void initState() {
    isIn = widget.type == 1;
    title = isIn ? 'Form Uang Masuk IPL' : 'Form Uang Keluar IPL';
    if (widget.id == null) {
      context.read<FormIplBloc>().add(OnInit(
            type: widget.type,
            blockCode: widget.blockCode,
            month: widget.month,
            year: widget.year,
          ));
    } else {
      context.read<FormIplBloc>().add(GetIplById(widget.id));
    }
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
    return BlocListener<FormIplBloc, FormIplState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Common.modalInfo(
            context,
            title: "Success",
            message: "Berhasil Merubah Data",
            mode: MODE.success,
          );
        }
        if (state.isError) {
          Common.modalInfo(
            context,
            title: "Gagal",
            message: state.errorMessage,
            mode: MODE.error,
          );
        }
        if (state.ipl?.date != null) {
          dateController.text = Jiffy.parse(state.ipl!.date!)
              .format(pattern: isIn ? "MMMM yyyy" : "dd MMMM yyyy");
        } else {
          dateController.text = "";
        }
      },
      child: BlocBuilder<FormIplBloc, FormIplState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Scaffold(
              appBar: CustomAppbar(
                title: title!,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          return CustomForm(
            title: title!,
            onSubmit: () {
              context.read<FormIplBloc>().add(OnSubmit(evidentBase64));
            },
            buttonTitle: "Simpan",
            children: [
              CustomFormField(
                title: isIn ? "Periode" : "Tanggal Keluar",
                textForm: CustomDatePicker(
                  enable: widget.id != null
                      ? true
                      : widget.month == null
                          ? true
                          : false,
                  display: isIn ? DISPLAY.month : DISPLAY.date,
                  focusNode: dateFocusNode,
                  validator: ValidForm.emptyValue,
                  onCloseDatepicker: (val) {
                    context.read<FormIplBloc>().add(OnChangedDate(val!));
                  },
                  controller: dateController,
                ),
              ),
              Visibility(
                visible: isIn,
                child: CustomFormField(
                  title: "Blok",
                  textForm: DropdownWidget<BlockDetail>(
                    enable: widget.id != null
                        ? true
                        : widget.blockCode == null
                            ? true
                            : false,
                    isVisible: isIn,
                    items: state.blockDetails ?? [],
                    itemAsString: (item) => item.name ?? "",
                    selectedItem: state.ipl?.blockDetail ?? BlockDetail(),
                    onChanged: (BlockDetail? data) => context
                        .read<FormIplBloc>()
                        .add(OnChangedBlockDetail(data!)),
                    validator: isIn
                        ? (value) => ValidForm.emptyValue(value?.name)
                        : null,
                    child: (item) {
                      return ListTile(
                        title: Text(
                          item.name ?? "",
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomFormField(
                title: "Jumlah Uang",
                textForm: TextFormField(
                  controller: amountController,
                  validator: widget.type == 1 ? ValidForm.emptyValue : null,
                  keyboardType: TextInputType.number,
                  decoration: TextFormDecoration.box(),
                  onChanged: (val) {
                    val = val == "" ? "0" : val;
                    double data = double.parse(val);
                    context.read<FormIplBloc>().add(OnChangedAmount(data));
                  },
                ),
              ),
              CustomFormField(
                title: "Keterangan",
                textForm: TextFormField(
                  controller: remarkController,
                  decoration: TextFormDecoration.box(),
                  onChanged: (val) {
                    context.read<FormIplBloc>().add(OnChangedNote(val));
                  },
                ),
              ),
              ImageCamera(
                base64: evidentBase64,
                data: state.ipl?.picture,
                onTap: (str) => evidentBase64 = str,
              ),
            ],
          );
        },
      ),
    );
  }
}
