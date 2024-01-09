import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/pages/parking/data/cash_flow.dart';
import 'package:fl_pbi/pages/parking/data/parking.dart';
import 'package:fl_pbi/pages/parking/data/parking_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'park_event.dart';
part 'park_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  ParkingBloc() : super(const ParkingState()) {
    on<OnGetTotal>(_onGetTotal);
    on<OnGetSummary>(_onGetSummary);
    on<OnLoadMore>(_onLoadMore);
  }

  void _onGetTotal(OnGetTotal event, Emitter<ParkingState> emit) async {
    emit(state.copyWith(cardLoaing: true));
    try {
      CashFlow cashFlow = await ParkingApi.getTotal();
      emit(state.copyWith(cardLoaing: false, cashFlow: cashFlow));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          cardLoaing: false,
          cashFlow: state.cashFlow,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          cardLoaing: false,
          cashFlow: state.cashFlow,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onGetSummary(OnGetSummary event, Emitter<ParkingState> emit) async {
    emit(state.copyWith(listLoading: true));
    try {
      ServerSide serverSide = await ParkingApi.get();
      List<Parking> parks = [];
      for (var v in (serverSide.data ?? [])) {
        parks.add(Parking.fromJson(v));
      }
      emit(state.copyWith(
        listLoading: false,
        serverSide: serverSide,
        parks: parks,
      ));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          listLoading: false,
          serverSide: state.serverSide,
          parks: state.parks,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          listLoading: false,
          serverSide: state.serverSide,
          parks: state.parks,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onLoadMore(OnLoadMore event, Emitter<ParkingState> emit) async {
    try {
      if (state.serverSide?.nextPageUrl != null) {
        ServerSide serverSide = await ParkingApi.get();
        List<Parking> parks = state.parks ?? [];
        for (var v in (serverSide.data ?? [])) {
          parks.add(Parking.fromJson(v));
        }
        emit(state.copyWith(
          serverSide: serverSide,
          parks: parks,
          loadMore: false,
        ));
      } else {
        emit(state.copyWith(loadMore: false));
      }
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          listLoading: false,
          serverSide: state.serverSide,
          parks: state.parks,
          isError: true,
          loadMore: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          listLoading: false,
          serverSide: state.serverSide,
          parks: state.parks,
          isError: true,
          loadMore: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
