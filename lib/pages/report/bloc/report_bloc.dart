import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/ipl/data/ipl_api.dart';
import 'package:fl_pbi/pages/parking/data/parking_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(const ReportState()) {
    on<OnChangedPeriode>(_onChangedPeriode);
    on<OnInitPDFView>(_onInitPDFView);
    on<OnInit>(_onInit);
  }

  void _onInit(OnInit event, Emitter<ReportState> emit) {
    emit(state.copyWith(isLoading: false, isError: false));
  }

  void _onChangedPeriode(OnChangedPeriode event, Emitter<ReportState> emit) {
    emit(state.copyWith(map: event.map));
  }

  void _onInitPDFView(OnInitPDFView event, Emitter<ReportState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      TransactionReport report = state.report ?? TransactionReport();
      if (event.reportType == "ipl") {
        report = await IplApi.getByDate(state.map!);
      } else {
        report = await ParkingApi.getByDate(state.map!);
      }
      emit(state.copyWith(report: report, isLoading: false, isError: false));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          report: state.report,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          report: state.report,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
