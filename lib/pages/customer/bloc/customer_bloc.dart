import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/customer/data/customer_api.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(const CustomerState()) {
    on<OnGetCustomer>(_onGetCustomer);
  }

  void _onGetCustomer(OnGetCustomer event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      ServerSide serverSide = await CustomerApi.get(params: event.map);
      List<Profile> customers = [];
      for (var v in (serverSide.data ?? [])) {
        customers.add(Profile.fromJson(v));
      }
      emit(state.copyWith(customers: customers, isLoading: false));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          customers: state.customers,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          customers: state.customers,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
