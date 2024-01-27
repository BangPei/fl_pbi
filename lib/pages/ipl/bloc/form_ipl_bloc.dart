import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/pages/block/data/block_api.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
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
  }

  void _onSubmit(OnSubmit event, Emitter<FormIplState> emit) async {
    IPL ipl = state.ipl ?? IPL();
    if (event.image != null) {
      ipl.picture = event.image;
    }
    ipl.type = event.type;
    print(ipl);
  }

  void _onChangedDate(OnChangedDate event, Emitter<FormIplState> emit) {
    IPL ipl = state.ipl ?? IPL();
    ipl.date = Jiffy.parseFromDateTime(event.val).format(pattern: "01-MM-yyyy");
    emit(state.copyWith(ipl: ipl));
  }

  void _onChangedBlockDetail(
      OnChangedBlockDetail event, Emitter<FormIplState> emit) {
    IPL ipl = state.ipl ?? IPL();
    ipl.blockDetail = event.detail;
    emit(state.copyWith(ipl: ipl));
  }

  void _onChangedNote(OnChangedNote event, Emitter<FormIplState> emit) {
    IPL ipl = state.ipl ?? IPL();
    ipl.note = event.val;
    emit(state.copyWith(ipl: ipl));
  }

  void _onChangedAmount(OnChangedAmount event, Emitter<FormIplState> emit) {
    IPL ipl = state.ipl ?? IPL();
    ipl.amount = event.val;
    emit(state.copyWith(ipl: ipl));
  }

  void _onInit(OnInit event, Emitter<FormIplState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      List<BlockDetail> details = await BlockApi.getBlockDetails();
      IPL ipl = state.ipl ?? IPL();

      if (details.isNotEmpty) {
        ipl.blockDetail = details[0];
      } else {
        ipl.blockDetail = BlockDetail();
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
}
