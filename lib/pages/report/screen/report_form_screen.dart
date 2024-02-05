import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/report/bloc/report_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

class ReportForm extends StatefulWidget {
  final String reportType;
  const ReportForm({super.key, required this.reportType});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  int type = 0;
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController dateController = TextEditingController();
  late FocusNode dateFocusNode;

  @override
  void initState() {
    context.read<ReportBloc>().add(const OnInit());
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
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state.isLoading ?? false) {
          return Scaffold(
            appBar: CustomAppbar(
              title: "Laporan ${widget.reportType}",
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: const LoadingScreen(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomForm(
            title: "Laporan ${widget.reportType}",
            onSubmit: () {
              context.goNamed(
                'report-transaction',
                extra: {'reportType': widget.reportType},
              );
            },
            buttonTitle: "Submit",
            showCard: false,
            children: [
              header(),
              type == 0
                  ? CustomFormField(
                      title: "Atur Tanggal",
                      textForm: TextFormField(
                        validator: ValidForm.emptyValue,
                        keyboardType: TextInputType.number,
                        decoration: TextFormDecoration.box(),
                        controller: dateController,
                        // onChanged: (val) {},
                        onTap: () {
                          showCustomDateRangePicker(
                            context,
                            dismissible: false,
                            minimumDate: DateTime(2000),
                            maximumDate: DateTime(3000),
                            endDate: endDate,
                            startDate: startDate,
                            backgroundColor: Colors.white,
                            primaryColor: AppTheme.blue,
                            onApplyClick: (start, end) {
                              setState(() {
                                endDate = end;
                                startDate = start;
                                if (startDate != null && endDate != null) {
                                  Map<String, dynamic> map = {
                                    "from": Jiffy.parseFromDateTime(start)
                                        .format(pattern: "yyyy-MM-dd"),
                                    "to": Jiffy.parseFromDateTime(end)
                                        .format(pattern: "yyyy-MM-dd"),
                                  };
                                  context
                                      .read<ReportBloc>()
                                      .add(OnChangedPeriode(map));
                                  dateController.text =
                                      '${Jiffy.parseFromDateTime(startDate!).format(pattern: 'dd MMMM yyyy')} - ${Jiffy.parseFromDateTime(endDate!).format(pattern: 'dd MMMM yyyy')}';
                                }
                              });
                            },
                            onCancelClick: () {
                              endDate = null;
                              startDate = null;
                              dateController.text = "";
                              setState(() {});
                            },
                          );
                        },
                      ),
                    )
                  : CustomFormField(
                      title: "Atur Bulan",
                      textForm: CustomDatePicker(
                        display: DISPLAY.month,
                        focusNode: dateFocusNode,
                        validator: ValidForm.emptyValue,
                        onCloseDatepicker: (val) {
                          Map<String, dynamic> map = {
                            "month": months
                                .where((e) =>
                                    e['no'] ==
                                    Jiffy.parseFromDateTime(val!)
                                        .format(pattern: "MM"))
                                .first['name'],
                            "year": Jiffy.parseFromDateTime(val!)
                                .format(pattern: "yyyy"),
                          };
                          context.read<ReportBloc>().add(OnChangedPeriode(map));
                        },
                        controller: dateController,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          const Text(
            "Tipe Laporan : ",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Button2Level(
              initIndex: type,
              label1: "Pertanggal",
              label2: "Perbulan",
              onTap: (idx) {
                type = idx;
                dateController.text = "";
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
