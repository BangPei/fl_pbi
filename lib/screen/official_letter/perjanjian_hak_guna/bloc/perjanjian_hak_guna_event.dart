part of 'perjanjian_hak_guna_bloc.dart';

abstract class PerjanjianHakGunaEvent extends Equatable {
  const PerjanjianHakGunaEvent();

  @override
  List<Object> get props => [];
}

class OnChangedNoSurat extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedNoSurat(this.val);
}

class OnChangedSignPlace extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedSignPlace(this.val);
}

class OnChangedDate extends PerjanjianHakGunaEvent {
  final DateTime? val;
  const OnChangedDate({this.val});
}

class OnChangedNamePihakPertama extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedNamePihakPertama(this.val);
}

class OnChangedDOBPihakPertama extends PerjanjianHakGunaEvent {
  final DateTime? val;
  const OnChangedDOBPihakPertama({this.val});
}

class OnChangedNikPihakPertama extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedNikPihakPertama(this.val);
}

class OnChangedPhonePihakPertama extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedPhonePihakPertama(this.val);
}

class OnChangedPosition extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedPosition(this.val);
}

class OnChangedAddressPihakPertama extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedAddressPihakPertama(this.val);
}

class OnChangedNamePihakKedua extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedNamePihakKedua(this.val);
}

class OnChangedNikPihakKedua extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedNikPihakKedua(this.val);
}

class OnChangedPhonePihakKedua extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedPhonePihakKedua(this.val);
}

class OnChangedJobPihakKedua extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedJobPihakKedua(this.val);
}

class OnChangedAddressPihakKedua extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedAddressPihakKedua(this.val);
}

class OnChangedLokasiKios extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedLokasiKios(this.val);
}

class OnChangedBlokKios extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedBlokKios(this.val);
}

class OnChangedNoKios extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedNoKios(this.val);
}

class OnChangedJumlahKios extends PerjanjianHakGunaEvent {
  final int val;
  const OnChangedJumlahKios(this.val);
}

class OnChangedLuasKios extends PerjanjianHakGunaEvent {
  final double val;
  const OnChangedLuasKios(this.val);
}

class OnChangedJangkaWaktu extends PerjanjianHakGunaEvent {
  final int val;
  const OnChangedJangkaWaktu(this.val);
}

class OnChangedTandaHakGuna extends PerjanjianHakGunaEvent {
  final String val;
  const OnChangedTandaHakGuna(this.val);
}

class OnChangedMasaBerlaku extends PerjanjianHakGunaEvent {
  final DateTime? val;
  const OnChangedMasaBerlaku({this.val});
}

class OnChangedSewaBulanan extends PerjanjianHakGunaEvent {
  final double val;
  const OnChangedSewaBulanan(this.val);
}

class OnChangedTagihanListrik extends PerjanjianHakGunaEvent {
  final double val;
  const OnChangedTagihanListrik(this.val);
}

class OnInit extends PerjanjianHakGunaEvent {
  const OnInit();
}

class OnSubmit extends PerjanjianHakGunaEvent {
  const OnSubmit();
}

class OnSubmitTemplate extends PerjanjianHakGunaEvent {
  const OnSubmitTemplate();
}
