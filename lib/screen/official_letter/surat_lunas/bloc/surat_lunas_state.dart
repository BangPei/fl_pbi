part of 'surat_lunas_bloc.dart';

class SuratLunasState extends Equatable {
  final SuratLunas? lunas;
  final bool isLoading;
  const SuratLunasState({this.lunas, this.isLoading = true});

  SuratLunasState copyWith({SuratLunas? lunas, bool? isLoading}) {
    return SuratLunasState(
      isLoading: isLoading ?? this.isLoading,
      lunas: lunas ?? this.lunas ?? SuratLunas(),
    );
  }

  @override
  List<Object?> get props => [lunas, isLoading];
}
