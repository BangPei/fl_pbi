part of 'permohonan_bloc.dart';

abstract class PermohonanEvent extends Equatable {
  const PermohonanEvent();
}

class OnChangedName extends PermohonanEvent {
  final String val;
  const OnChangedName(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedNik extends PermohonanEvent {
  final String val;
  const OnChangedNik(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedPhone extends PermohonanEvent {
  final String val;
  const OnChangedPhone(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedAddress extends PermohonanEvent {
  final String val;
  const OnChangedAddress(this.val);
  @override
  List<Object?> get props => [];
}

class OnSubmit extends PermohonanEvent {
  const OnSubmit();
  @override
  List<Object?> get props => [];
}

class OnSubmitTemplate extends PermohonanEvent {
  const OnSubmitTemplate();
  @override
  List<Object?> get props => [];
}
