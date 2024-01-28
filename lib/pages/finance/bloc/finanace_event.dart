part of 'finanace_bloc.dart';

abstract class FinanceEvent extends Equatable {
  const FinanceEvent();
}

class OnGetTotal extends FinanceEvent {
  @override
  List<Object?> get props => [];
}
