import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/number.dart';
import 'package:fl_pbi/pages/profile/data/block_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_event.dart';
part 'number_state.dart';

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  NumberBloc() : super(const NumberState()) {
    on<GetNumbers>(_onGetNumbers);
    on<OnSubmit>(_onSubmit);
    on<OnChangedNumber>(_onChangedNumber);
  }

  void _onChangedNumber(OnChangedNumber event, Emitter<NumberState> emit) {
    emit(state.copyWith(number: event.val));
  }

  void _onGetNumbers(GetNumbers event, Emitter<NumberState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      List<Number> numbers = await BlockApi.getNumbers();
      emit(state.copyWith(isLoading: false, isError: false, numbers: numbers));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          numbers: state.numbers,
          isSuccess: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          numbers: state.numbers,
          isError: true,
          isSuccess: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onSubmit(OnSubmit event, Emitter<NumberState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await BlockApi.postNumber({"name": state.number});
      List<Number> numbers = await BlockApi.getNumbers();
      emit(state.copyWith(isLoading: false, isError: false, numbers: numbers));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          numbers: state.numbers,
          number: state.number,
          isSuccess: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          numbers: state.numbers,
          number: state.number,
          isError: true,
          isSuccess: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
