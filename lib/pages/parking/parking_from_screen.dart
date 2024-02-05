import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/parking/bloc/park_form_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

class ParkingFormScreen extends StatefulWidget {
  final int type;
  final int? id;
  const ParkingFormScreen({super.key, required this.type, this.id});

  @override
  State<ParkingFormScreen> createState() => _ParkingFormScreenState();
}

class _ParkingFormScreenState extends State<ParkingFormScreen> {
  String? evidentBase64;
  late FocusNode dateFocusNode;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  get buttonTitle => null;

  @override
  void initState() {
    if (widget.id != null) {
      context.read<ParkFormBloc>().add(OnGetPark(widget.id!));
    } else {
      context.read<ParkFormBloc>().add(OnResetForm(widget.type));
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
    return BlocListener<ParkFormBloc, ParkFormState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Common.modalInfo(
            context,
            title: "Success",
            message: "Berhasil Merubah Data",
            mode: MODE.success,
          );
        }
        if (state.park?.date != null) {
          dateController.text =
              Jiffy.parse(state.park!.date!).format(pattern: "dd MMMM yyyy");
        }
        amountController.text = (state.park?.amount ?? 0).toString();
        remarkController.text = state.park?.remark ?? "";
      },
      child: BlocBuilder<ParkFormBloc, ParkFormState>(
        builder: (context, state) {
          if (state.listLoading) {
            return Scaffold(
              appBar: CustomAppbar(
                title:
                    "Form Uang ${widget.type == 1 ? 'Masuk' : 'Keluar'} Parkir",
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          return CustomForm(
            title: "Form Uang ${widget.type == 1 ? 'Masuk' : 'Keluar'}",
            onSubmit: () {
              context
                  .read<ParkFormBloc>()
                  .add(OnSubmit(type: widget.type, image: evidentBase64));
            },
            buttonTitle: "Simpan",
            children: [
              CustomFormField(
                title: "Tanggal",
                textForm: CustomDatePicker(
                  focusNode: dateFocusNode,
                  validator: ValidForm.emptyValue,
                  onCloseDatepicker: (val) {
                    context.read<ParkFormBloc>().add(OnChangedDate(val: val));
                  },
                  controller: dateController,
                ),
              ),
              CustomFormField(
                title: "Jumlah Uang",
                textForm: TextFormField(
                  // initialValue: (state.park?.amount ?? 0).toString(),
                  controller: amountController,
                  validator: ValidForm.emptyValue,
                  keyboardType: TextInputType.number,
                  decoration: TextFormDecoration.box(),
                  onChanged: (val) {
                    if (val != "" || val.isNotEmpty) {
                      double value = double.parse(val);
                      context.read<ParkFormBloc>().add(OnChangedAmount(value));
                    }
                  },
                ),
              ),
              CustomFormField(
                title: "Keterangan",
                textForm: TextFormField(
                  // initialValue: state.park?.remark ?? "",
                  controller: remarkController,
                  validator: ValidForm.emptyValue,
                  decoration: TextFormDecoration.box(),
                  onChanged: (val) {
                    context.read<ParkFormBloc>().add(OnChangedRemark(val));
                  },
                ),
              ),
              ImageCamera(
                base64: evidentBase64,
                data: state.park?.picture,
                onTap: (str) => evidentBase64 = str,
              )
            ],
          );
        },
      ),
    );
  }
}
