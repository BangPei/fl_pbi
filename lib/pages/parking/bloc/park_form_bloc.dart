import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/parking/data/parking_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

part 'park_form_event.dart';
part 'park_form_state.dart';

class ParkFormBloc extends Bloc<ParkFormEvent, ParkFormState> {
  ParkFormBloc() : super(const ParkFormState()) {
    on<OnChangedDate>(_onChangedDate);
    on<OnChangedAmount>(_onChangedAmount);
    on<OnChangedRemark>(_onChangedRemark);
    on<OnSubmit>(_onSubmit);
    on<OnGetPark>(_onGetPark);
    on<OnResetForm>(_onResetForm);
  }

  void _onResetForm(OnResetForm event, Emitter<ParkFormState> emit) async {
    Transaction park = Transaction();
    park.type = event.type;
    emit(state.copyWith(
      park: park,
      listLoading: false,
      isError: false,
      isSuccess: false,
    ));
  }

  void _onChangedDate(OnChangedDate event, Emitter<ParkFormState> emit) {
    Transaction park = state.park ?? Transaction();
    if (event.val == null) {
      park.date = null;
    } else {
      park.date =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    }
    emit(state.copyWith(park: park));
  }

  void _onChangedAmount(OnChangedAmount event, Emitter<ParkFormState> emit) {
    Transaction park = state.park ?? Transaction();
    park.amount = event.val;
    emit(state.copyWith(park: park));
  }

  void _onChangedRemark(OnChangedRemark event, Emitter<ParkFormState> emit) {
    Transaction? park = state.park ?? Transaction();
    park.remark = event.val;
    emit(state.copyWith(park: park));
  }

  void _onGetPark(OnGetPark event, Emitter<ParkFormState> emit) async {
    try {
      emit(state.copyWith(listLoading: true, isSuccess: false));
      Transaction park = await ParkingApi.getId(event.id);
      emit(state.copyWith(
        listLoading: false,
        park: park,
      ));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          listLoading: false,
          park: state.park,
          isError: true,
          isSuccess: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          listLoading: false,
          park: state.park,
          isError: true,
          isSuccess: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onSubmit(OnSubmit event, Emitter<ParkFormState> emit) async {
    try {
      emit(state.copyWith(listLoading: true));
      Transaction? park = state.park ?? Transaction();
      park.type = event.type;
      if (event.image != null) {
        park.picture = event.image;
      }
      if (park.id != null) {
        park = await ParkingApi.put(park);
      } else {
        park = await ParkingApi.post(park);
      }
      emit(state.copyWith(park: park, listLoading: false, isSuccess: true));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          listLoading: false,
          park: state.park,
          isError: true,
          isSuccess: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          listLoading: false,
          park: state.park,
          isError: true,
          isSuccess: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
