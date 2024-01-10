import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/pages/parking/data/parking.dart';
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
  }

  void _onChangedDate(OnChangedDate event, Emitter<ParkFormState> emit) {
    Parking park = state.park ?? Parking();
    if (event.val == null) {
      park.date = null;
    } else {
      park.date =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    }
    emit(state.copyWith(park: park));
  }

  void _onChangedAmount(OnChangedAmount event, Emitter<ParkFormState> emit) {
    Parking park = state.park ?? Parking();
    park.amount = event.val;
    emit(state.copyWith(park: park));
  }

  void _onChangedRemark(OnChangedRemark event, Emitter<ParkFormState> emit) {
    Parking? park = state.park ?? Parking();
    park.remark = event.val;
    emit(state.copyWith(park: park));
  }

  void _onSubmit(OnSubmit event, Emitter<ParkFormState> emit) async {
    try {
      emit(state.copyWith(listLoading: true));
      Parking? park = state.park ?? Parking();
      park.type = event.type;
      park.picture = event.image;
      park = await ParkingApi.post(park);
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
