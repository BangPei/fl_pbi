import 'package:fl_pbi/pages/report/bloc/report_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

class ReportPDFScreen extends StatefulWidget {
  final String reportType;
  const ReportPDFScreen({
    super.key,
    required this.reportType,
  });

  @override
  State<ReportPDFScreen> createState() => _ReportPDFScreenState();
}

class _ReportPDFScreenState extends State<ReportPDFScreen> {
  @override
  void initState() {
    context.read<ReportBloc>().add(OnInitPDFView(widget.reportType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state.isLoading ?? false) {
          return const Scaffold(
            body: LoadingScreen(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    await Printing.layoutPdf(
                        onLayout: (format) => state.report!.pdf(
                            reportType: widget.reportType, map: state.map!));
                  },
                  icon: const Icon(Icons.print)),
            ],
          ),
          body: PdfPreview(
            maxPageWidth: 700,
            build: (format) => state.report!
                .pdf(reportType: widget.reportType, map: state.map!),
            canDebug: false,
            canChangeOrientation: false,
            allowSharing: false,
            canChangePageFormat: false,
            useActions: false,
            pdfFileName:
                "${widget.reportType.toUpperCase()} ${DateTime.now().millisecond.toString()}",
            // onPrinted: _showPrintedToast,
            // onShared: _showSharedToast,
            loadingWidget: const LoadingScreen(),
          ),
        );
      },
    );
  }
}
