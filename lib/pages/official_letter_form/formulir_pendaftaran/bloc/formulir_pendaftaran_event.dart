part of 'formulir_pendaftaran_bloc.dart';

abstract class FormulirPendaftaranEvent extends Equatable {
  const FormulirPendaftaranEvent();

  @override
  List<Object> get props => [];
}

class OnNameChanged extends FormulirPendaftaranEvent {
  final String vals;
  const OnNameChanged(this.vals);
}

class OnNikChanged extends FormulirPendaftaranEvent {
  final String vals;
  const OnNikChanged(this.vals);
}

class OnPhoneChanged extends FormulirPendaftaranEvent {
  final String vals;
  const OnPhoneChanged(this.vals);
}

class OnBlockChanged extends FormulirPendaftaranEvent {
  final String vals;
  const OnBlockChanged(this.vals);
}

class OnAddressChanged extends FormulirPendaftaranEvent {
  final String vals;
  const OnAddressChanged(this.vals);
}

class OnPicChanged extends FormulirPendaftaranEvent {
  final String vals;
  const OnPicChanged(this.vals);
}

class OnSubmit extends FormulirPendaftaranEvent {
  const OnSubmit();
}

class OnSubmitTemplate extends FormulirPendaftaranEvent {
  const OnSubmitTemplate();
}
