part of 'permohonan_bloc.dart';

class PermohonanState extends Equatable {
  final SuratPermohonan? permohonan;
  const PermohonanState({this.permohonan});

  PermohonanState copyWith({SuratPermohonan? permohonan}) {
    return PermohonanState(
      permohonan: permohonan ?? this.permohonan ?? SuratPermohonan(),
    );
  }

  @override
  List<Object?> get props => [permohonan];
}
