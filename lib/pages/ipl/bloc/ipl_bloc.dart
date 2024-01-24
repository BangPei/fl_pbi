import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/cash_flow.dart';
import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/models/trans.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
import 'package:fl_pbi/pages/ipl/data/ipl_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ipl_event.dart';
part 'ipl_state.dart';

class IplBloc extends Bloc<IplEvent, IplState> {
  IplBloc() : super(const IplState()) {
    on<OnGetTotal>(_onGetTotal);
    on<OnGetTrans>(_onGetTrans);
  }

  void _onGetTotal(OnGetTotal event, Emitter<IplState> emit) async {
    try {
      emit(state.copyWith(cardLoaing: true));
      CashFlow cashFlow = await IplApi.getTotal();
      emit(state.copyWith(cardLoaing: false, cashFlow: cashFlow));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          cardLoaing: false,
          cashFlow: state.cashFlow,
          trans: state.trans,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          cardLoaing: false,
          cashFlow: state.cashFlow,
          trans: state.trans,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onGetTrans(OnGetTrans event, Emitter<IplState> emit) async {
    try {
      emit(state.copyWith(listLoading: true));
      List<Trans> trans = await IplApi.getyearly(event.year, event.type);
      emit(state.copyWith(listLoading: false, trans: trans));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          cardLoaing: false,
          listLoading: false,
          cashFlow: state.cashFlow,
          trans: state.trans,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          cardLoaing: false,
          listLoading: false,
          cashFlow: state.cashFlow,
          trans: state.trans,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
