part of 'sewa_lahan_bloc.dart';

abstract class SewaLahanEvent extends Equatable {
  const SewaLahanEvent();

  @override
  List<Object> get props => [];
}

class OnChangedPihakPertama extends SewaLahanEvent {
  final String val;
  const OnChangedPihakPertama(this.val);
}

class OnChangedPihakKedua extends SewaLahanEvent {
  final String val;
  const OnChangedPihakKedua(this.val);
}

class OnChangedNik extends SewaLahanEvent {
  final String val;
  const OnChangedNik(this.val);
}

class OnChangedPhone extends SewaLahanEvent {
  final String val;
  const OnChangedPhone(this.val);
}

class OnChangedAddress extends SewaLahanEvent {
  final String val;
  const OnChangedAddress(this.val);
}

class OnChangedAreaLahan extends SewaLahanEvent {
  final String val;
  const OnChangedAreaLahan(this.val);
}

class OnChangedPemilikArea extends SewaLahanEvent {
  final String val;
  const OnChangedPemilikArea(this.val);
}

class OnChangedLuasArea extends SewaLahanEvent {
  final double val;
  const OnChangedLuasArea(this.val);
}

class OnChangedDurasiSewa extends SewaLahanEvent {
  final int val;
  const OnChangedDurasiSewa(this.val);
}

class OnChangedDurasiPerpanjangan extends SewaLahanEvent {
  final int val;
  const OnChangedDurasiPerpanjangan(this.val);
}

class OnChangedTanggalPerjanjian extends SewaLahanEvent {
  final DateTime? val;
  const OnChangedTanggalPerjanjian({this.val});
}
