part of 'surat_lunas_bloc.dart';

abstract class SuratLunasEvent extends Equatable {
  const SuratLunasEvent();

  @override
  List<Object> get props => [];
}

class OnNameChanged extends SuratLunasEvent {
  final String val;
  const OnNameChanged(this.val);
}

class OnNikChanged extends SuratLunasEvent {
  final String val;
  const OnNikChanged(this.val);
}

class OnPositionChanged extends SuratLunasEvent {
  final String val;
  const OnPositionChanged(this.val);
}

class OnPhoneChanged extends SuratLunasEvent {
  final String val;
  const OnPhoneChanged(this.val);
}

class OnAddressChanged extends SuratLunasEvent {
  final String val;
  const OnAddressChanged(this.val);
}

class OnDateChanged extends SuratLunasEvent {
  final DateTime? val;
  const OnDateChanged({this.val});
}

class OnBlockChanged extends SuratLunasEvent {
  final String val;
  const OnBlockChanged(this.val);
}

class OnInitLunas extends SuratLunasEvent {
  const OnInitLunas();
}

class OnSubmit extends SuratLunasEvent {
  const OnSubmit();
}

class OnSubmitTemplate extends SuratLunasEvent {
  const OnSubmitTemplate();
}
