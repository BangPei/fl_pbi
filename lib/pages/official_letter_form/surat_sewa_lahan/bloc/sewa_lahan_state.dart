part of 'sewa_lahan_bloc.dart';

class SewaLahanState extends Equatable {
  final SuratSewaLahan? sewaLahan;
  const SewaLahanState({this.sewaLahan});

  SewaLahanState copyWith({SuratSewaLahan? sewaLahan}) {
    return SewaLahanState(sewaLahan: sewaLahan ?? this.sewaLahan);
  }

  @override
  List<Object?> get props => [sewaLahan];
}
