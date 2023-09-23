part of 'formulir_pendaftaran_bloc.dart';

class FormulirPendaftaranState extends Equatable {
  final Pendaftaran? pendaftaran;
  const FormulirPendaftaranState({this.pendaftaran});

  FormulirPendaftaranState copyWith({Pendaftaran? pendaftaran}) {
    return FormulirPendaftaranState(
        pendaftaran: pendaftaran ?? this.pendaftaran ?? Pendaftaran());
  }

  @override
  List<Object?> get props => [pendaftaran];
}
