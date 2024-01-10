part of 'park_form_bloc.dart';

abstract class ParkFormEvent extends Equatable {
  const ParkFormEvent();
}

class OnChangedDate extends ParkFormEvent {
  final DateTime? val;
  const OnChangedDate({this.val});
  @override
  List<Object?> get props => [];
}

class OnChangedAmount extends ParkFormEvent {
  final int val;
  const OnChangedAmount(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedRemark extends ParkFormEvent {
  final String val;
  const OnChangedRemark(this.val);
  @override
  List<Object?> get props => [];
}

class OnSubmit extends ParkFormEvent {
  final String? image;
  final int? type;
  const OnSubmit({this.image, this.type});
  @override
  List<Object?> get props => [];
}
