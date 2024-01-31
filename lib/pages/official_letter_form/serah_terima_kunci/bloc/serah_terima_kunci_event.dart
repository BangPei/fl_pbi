part of 'serah_terima_kunci_bloc.dart';

abstract class SerahTerimaKunciEvent extends Equatable {
  const SerahTerimaKunciEvent();

  @override
  List<Object> get props => [];
}

class OnChangedSignPlace extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedSignPlace(this.val);
}

class OnChangedDate extends SerahTerimaKunciEvent {
  final DateTime? val;
  const OnChangedDate({this.val});
}

class OnChangedNamePihakPertama extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedNamePihakPertama(this.val);
}

class OnChangedNikPihakPertama extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedNikPihakPertama(this.val);
}

class OnChangedPhonePihakPertama extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedPhonePihakPertama(this.val);
}

class OnChangedPosition extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedPosition(this.val);
}

class OnChangedAddressPihakPertama extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedAddressPihakPertama(this.val);
}

class OnChangedNamePihakKedua extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedNamePihakKedua(this.val);
}

class OnChangedNikPihakKedua extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedNikPihakKedua(this.val);
}

class OnChangedPhonePihakKedua extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedPhonePihakKedua(this.val);
}

class OnChangedAddressPihakKedua extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedAddressPihakKedua(this.val);
}

class OnChangedBlokKios extends SerahTerimaKunciEvent {
  final String val;
  const OnChangedBlokKios(this.val);
}

class OnInit extends SerahTerimaKunciEvent {
  const OnInit();
}

class OnSubmit extends SerahTerimaKunciEvent {
  const OnSubmit();
}

class OnSubmitTemplate extends SerahTerimaKunciEvent {
  const OnSubmitTemplate();
}
