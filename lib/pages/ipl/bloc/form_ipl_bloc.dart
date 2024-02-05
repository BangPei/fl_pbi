import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/block/data/block_api.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/ipl/data/ipl_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

part 'form_ipl_event.dart';
part 'form_ipl_state.dart';

class FormIplBloc extends Bloc<FormIplEvent, FormIplState> {
  FormIplBloc() : super(const FormIplState()) {
    on<OnInit>(_onInit);
    on<OnChangedBlockDetail>(_onChangedBlockDetail);
    on<OnChangedNote>(_onChangedNote);
    on<OnChangedAmount>(_onChangedAmount);
    on<OnChangedDate>(_onChangedDate);
    on<OnSubmit>(_onSubmit);
    on<GetIplById>(_onGetIplById);
  }

  void _onSubmit(OnSubmit event, Emitter<FormIplState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      Transaction ipl = state.ipl ?? Transaction();
      if (event.image != null) {
        ipl.picture = event.image;
      }
      Transaction newIpl = await IplApi.post(ipl);
      emit(state.copyWith(ipl: newIpl, isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        ipl: state.ipl,
        isSuccess: false,
        blockDetails: state.blockDetails,
      ));
    }
  }

  void _onChangedDate(OnChangedDate event, Emitter<FormIplState> emit) {
    Transaction ipl = state.ipl ?? Transaction();
    ipl.date = Jiffy.parseFromDateTime(event.val)
        .format(pattern: ipl.type == 1 ? "yyyy-MM-01" : "yyyy-MM-dd");
    emit(state.copyWith(ipl: ipl));
  }

  void _onChangedBlockDetail(
      OnChangedBlockDetail event, Emitter<FormIplState> emit) {
    Transaction ipl = state.ipl ?? Transaction();
    ipl.blockDetail = event.detail;
    emit(state.copyWith(ipl: ipl));
  }

  void _onChangedNote(OnChangedNote event, Emitter<FormIplState> emit) {
    Transaction ipl = state.ipl ?? Transaction();
    ipl.note = event.val;
    emit(state.copyWith(ipl: ipl));
  }

  void _onChangedAmount(OnChangedAmount event, Emitter<FormIplState> emit) {
    Transaction ipl = state.ipl ?? Transaction();
    ipl.amount = event.val;
    emit(state.copyWith(ipl: ipl));
  }

  void _onInit(OnInit event, Emitter<FormIplState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, isError: false));
    try {
      List<BlockDetail> details = await BlockApi.getBlockDetails();
      Transaction ipl = Transaction();
      ipl.type = event.type;
      if (event.blockCode != null) {
        ipl.blockDetail = state.ipl?.blockDetail ?? BlockDetail();
        ipl.blockDetail = details.where((s) => s.code == event.blockCode).first;
      }
      if (event.month != null && event.year != null) {
        String monthNo = months
            .where((e) => e['name'] == event.month?.toLowerCase())
            .first['no'];
        ipl.date =
            Jiffy.parse("01-$monthNo-${event.year}", pattern: "dd-MM-yyyy")
                .format(pattern: "yyyy-MM-dd");
      }
      emit(state.copyWith(
        blockDetails: details,
        ipl: ipl,
        isLoading: false,
        isSuccess: false,
      ));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          ipl: state.ipl,
          isSuccess: false,
          blockDetails: state.blockDetails,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          ipl: state.ipl,
          isSuccess: false,
          blockDetails: state.blockDetails,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onGetIplById(GetIplById event, Emitter<FormIplState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, isError: false));
    try {
      List<BlockDetail> details = await BlockApi.getBlockDetails();
      Transaction ipl = await IplApi.getId(event.id!);

      emit(state.copyWith(
        blockDetails: details,
        ipl: ipl,
        isLoading: false,
        isSuccess: false,
      ));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          ipl: state.ipl,
          isSuccess: false,
          blockDetails: state.blockDetails,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          ipl: state.ipl,
          isSuccess: false,
          blockDetails: state.blockDetails,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
