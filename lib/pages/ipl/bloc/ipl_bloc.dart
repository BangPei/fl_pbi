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
    on<OnGetOutDetail>(_onGetOutDetail);
    on<OnGetTotal>(_onGetTotal);
    on<OnGetTrans>(_onGetTrans);
    on<OnGetSummary>(_onGetSummary);
    on<OnLoadMore>(_onLoadMore);
    on<OnRemoveIPL>(_onRemoveIPL);
    on<OnChangedPanelOpen>(_onChangedPanelOpen);
  }

  void _onRemoveIPL(OnRemoveIPL event, Emitter<IplState> emit) async {
    emit(state.copyWith(listLoading: true));
    try {
      await IplApi.delete(event.id!);
      if (event.map['type'] == 1) {
        List<Block> blocks = await BlockApi.getBlocks(params: event.map);
        List<bool> listOpen = [];
        for (var i = 0; i < blocks.length; i++) {
          listOpen.add(false);
        }
        emit(state.copyWith(blocks: blocks, listOpen: listOpen));
      } else {
        List<IPL> ipls = state.ipls ?? [];
        ipls.removeWhere((e) => e.id == event.id);
        emit(state.copyWith(ipls: ipls));
      }
      emit(state.copyWith(listLoading: false));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          listLoading: false,
          serverSide: state.serverSide,
          cashFlow: state.cashFlow,
          ipls: state.ipls,
          isError: true,
          loadMore: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          listLoading: false,
          serverSide: state.serverSide,
          ipls: state.ipls,
          cashFlow: state.cashFlow,
          isError: true,
          loadMore: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onLoadMore(OnLoadMore event, Emitter<IplState> emit) async {
    try {
      if (state.serverSide?.nextPageUrl != null) {
        emit(state.copyWith(loadMore: true));
        Map<String, dynamic> params = {};
        var url = Uri.parse(state.serverSide!.nextPageUrl!);
        List<String> listParam = url.query.split("&");
        for (var v in listParam) {
          params[v.split("=")[0]] = v.split("=")[1];
        }
        ServerSide serverSide = await IplApi.get(params: params);
        List<IPL> ipls = state.ipls ?? [];
        for (var v in (serverSide.data ?? [])) {
          ipls.add(IPL.fromJson(v));
        }
        emit(state.copyWith(
          serverSide: serverSide,
          ipls: ipls,
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
          ipls: state.ipls,
          isError: true,
          loadMore: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          listLoading: false,
          serverSide: state.serverSide,
          ipls: state.ipls,
          isError: true,
          loadMore: false,
          errorMessage: e.toString(),
        ));
      }
    }
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
      if (trans.isNotEmpty) {
        trans.sort((a, b) => a.no!.compareTo(b.no!));
      }
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

  void _onGetOutDetail(OnGetOutDetail event, Emitter<IplState> emit) async {
    try {
      emit(state.copyWith(listLoading: true));
      ServerSide serverside = await IplApi.get(params: event.map);
      List<IPL> ipls = [];
      for (var v in (serverside.data ?? [])) {
        ipls.add(IPL.fromJson(v));
      }
      emit(state.copyWith(
        listLoading: false,
        serverSide: serverside,
        ipls: ipls,
      ));
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
