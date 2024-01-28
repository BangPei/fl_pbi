part of 'form_ipl_bloc.dart';

abstract class FormIplEvent extends Equatable {
  const FormIplEvent();
}

class OnInit extends FormIplEvent {
  final int type;
  const OnInit(this.type);
  @override
  List<Object?> get props => [];
}

class OnChangedBlockDetail extends FormIplEvent {
  final BlockDetail detail;
  const OnChangedBlockDetail(this.detail);
  @override
  List<Object?> get props => [];
}

class OnChangedDate extends FormIplEvent {
  final DateTime val;
  const OnChangedDate(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedAmount extends FormIplEvent {
  final double val;
  const OnChangedAmount(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedNote extends FormIplEvent {
  final String val;
  const OnChangedNote(this.val);
  @override
  List<Object?> get props => [];
}

class OnSubmit extends FormIplEvent {
  final String? image;
  const OnSubmit(this.image);
  @override
  List<Object?> get props => [];
}
