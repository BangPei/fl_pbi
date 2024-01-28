import 'package:equatable/equatable.dart';
import 'package:fl_pbi/pages/finance/data/finance.dart';
import 'package:fl_pbi/pages/finance/data/finance_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'finanace_event.dart';
part 'finanace_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc() : super(const FinanceState()) {
    on<OnGetTotal>(_onGetTotal);
  }

  void _onGetTotal(OnGetTotal event, Emitter<FinanceState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      Finance finance = await FinanceApi.getTotal();
      emit(state.copyWith(finance: finance, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        finance: state.finance,
      ));
    }
  }
}
