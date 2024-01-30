import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/pages/block/data/block_api.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
import 'package:fl_pbi/pages/ipl/data/ipl_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ipl_event.dart';
part 'ipl_state.dart';

class IplBloc extends Bloc<IplEvent, IplState> {
  IplBloc() : super(const IplState()) {
    on<OnGetTotal>(_onGetTotal);
    on<OnGetTrans>(_onGetTrans);
    on<OnGetSummary>(_onGetSummary);
    on<OnChangedPanelOpen>(_onChangedPanelOpen);
  }

  void _onChangedPanelOpen(OnChangedPanelOpen event, Emitter<IplState> emit) {
    List<bool> listOpen = state.listOpen ?? [];
    listOpen[event.index] = event.expand;
    emit(state.copyWith(listOpen: listOpen));
  }

  void _onGetSummary(OnGetSummary event, Emitter<IplState> emit) async {
    emit(state.copyWith(listLoading: true));
    try {
      List<Block> blocks = await BlockApi.getBlocks(params: event.map);
      List<bool> listOpen = [];
      for (var i = 0; i < blocks.length; i++) {
        listOpen.add(false);
      }
      emit(state.copyWith(
        listLoading: false,
        blocks: blocks,
        listOpen: listOpen,
      ));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          cardLoaing: false,
          cashFlow: state.cashFlow,
          ipls: state.ipls,
          serverSide: state.serverSide,
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
          ipls: state.ipls,
          serverSide: state.serverSide,
          errorMessage: e.toString(),
        ));
      }
    }
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
