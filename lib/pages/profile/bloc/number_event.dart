part of 'number_bloc.dart';

abstract class NumberEvent extends Equatable {
  const NumberEvent();
}

class GetNumbers extends NumberEvent {
  const GetNumbers();
  @override
  List<Object?> get props => [];
}

class OnSubmit extends NumberEvent {
  const OnSubmit();
  @override
  List<Object?> get props => [];
}

class OnChangedNumber extends NumberEvent {
  final String val;
  const OnChangedNumber(this.val);
  @override
  List<Object?> get props => [];
}
