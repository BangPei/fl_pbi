part of 'tanda_hak_guna_bloc.dart';

abstract class TandaHakGunaEvent extends Equatable {
  const TandaHakGunaEvent();

  @override
  List<Object> get props => [];
}

class OnSubmit extends TandaHakGunaEvent {
  const OnSubmit();
}

class OnSubmitTemplate extends TandaHakGunaEvent {
  const OnSubmitTemplate();
}

class OnInit extends TandaHakGunaEvent {
  const OnInit();
}

class OnChangedNomorSurat extends TandaHakGunaEvent {
  final String val;
  const OnChangedNomorSurat(this.val);
}

class OnChangedTempatDibuat extends TandaHakGunaEvent {
  final String val;
  const OnChangedTempatDibuat(this.val);
}

class OnChangedTanggalDibuat extends TandaHakGunaEvent {
  final DateTime? val;
  const OnChangedTanggalDibuat({this.val});
}

class OnChangedNamaPihakPertama extends TandaHakGunaEvent {
  final String val;
  const OnChangedNamaPihakPertama(this.val);
}

class OnChangedDOBPihakPertama extends TandaHakGunaEvent {
  final DateTime? val;
  const OnChangedDOBPihakPertama({this.val});
}

class OnChangedNikPihakPertama extends TandaHakGunaEvent {
  final String val;
  const OnChangedNikPihakPertama(this.val);
}

class OnChangedPhonePihakPertama extends TandaHakGunaEvent {
  final String val;
  const OnChangedPhonePihakPertama(this.val);
}

class OnChangedJobPihakPertama extends TandaHakGunaEvent {
  final String val;
  const OnChangedJobPihakPertama(this.val);
}

class OnChangedAddressPihakPertama extends TandaHakGunaEvent {
  final String val;
  const OnChangedAddressPihakPertama(this.val);
}

class OnChangedNamePihakKedua extends TandaHakGunaEvent {
  final String val;
  const OnChangedNamePihakKedua(this.val);
}

class OnChangedNikPihakKedua extends TandaHakGunaEvent {
  final String val;
  const OnChangedNikPihakKedua(this.val);
}

class OnChangedAddressPihakKedua extends TandaHakGunaEvent {
  final String val;
  const OnChangedAddressPihakKedua(this.val);
}

class OnChangedLocation extends TandaHakGunaEvent {
  final String val;
  const OnChangedLocation(this.val);
}

class OnChangedBlock extends TandaHakGunaEvent {
  final String val;
  const OnChangedBlock(this.val);
}

class OnChangedBlockNo extends TandaHakGunaEvent {
  final String val;
  const OnChangedBlockNo(this.val);
}

class OnChangedJumlahKios extends TandaHakGunaEvent {
  final int val;
  const OnChangedJumlahKios(this.val);
}

class OnChangedMasaBerlaku extends TandaHakGunaEvent {
  final DateTime? val;
  const OnChangedMasaBerlaku({this.val});
}

class OnChangedNoPerjanjian extends TandaHakGunaEvent {
  final String val;
  const OnChangedNoPerjanjian(this.val);
}
