import 'package:equatable/equatable.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

part 'sewa_lahan_event.dart';
part 'sewa_lahan_state.dart';

class SewaLahanBloc extends Bloc<SewaLahanEvent, SewaLahanState> {
  SewaLahanBloc() : super(const SewaLahanState()) {
    on<OnChangedPihakPertama>(_onChangedPihakPertama);
    on<OnChangedPihakKedua>(_onChangedPihakKedua);
    on<OnChangedNik>(_onChangedNik);
    on<OnChangedPhone>(_onChangedPhone);
    on<OnChangedAddress>(_onChangedAddress);
    on<OnChangedAreaLahan>(_onChangedAreaLahan);
    on<OnChangedPemilikArea>(_onChangedPemilikArea);
    on<OnChangedLuasArea>(_onChangedLuasArea);
    on<OnChangedDurasiSewa>(_onChangedDurasiSewa);
    on<OnChangedDurasiPerpanjangan>(_onChangedDurasiPerpanjangan);
    on<OnChangedTanggalPerjanjian>(_onChangedTanggalPerjanjian);
  }

  void _onChangedTanggalPerjanjian(
      OnChangedTanggalPerjanjian event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    if (event.val != null) {
      sewaLahan.date =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
      if ((sewaLahan.periodeRent != null) || (sewaLahan.periodeRent ?? 0) > 0) {
        var newDate = Jiffy.parseFromDateTime(event.val!)
            .add(years: sewaLahan.periodeRent!)
            .format(pattern: 'yyyy-MM-dd');
        sewaLahan.periodeDate = newDate;
      }
    } else {
      sewaLahan.date = null;
      sewaLahan.periodeDate = null;
    }
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedDurasiPerpanjangan(
      OnChangedDurasiPerpanjangan event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.extraTime = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedDurasiSewa(
      OnChangedDurasiSewa event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.periodeRent = event.val;
    if (sewaLahan.date != null) {
      var newDate = Jiffy.parse(sewaLahan.date!)
          .add(years: event.val)
          .format(pattern: 'yyyy-MM-dd');
      sewaLahan.periodeDate = newDate;
    } else {
      sewaLahan.periodeDate = null;
    }
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedLuasArea(
      OnChangedLuasArea event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.wide = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPemilikArea(
      OnChangedPemilikArea event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.areaCompany = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedAreaLahan(
      OnChangedAreaLahan event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.areaName = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedAddress(OnChangedAddress event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.address = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPhone(OnChangedPhone event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.phone = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedNik(OnChangedNik event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.nik = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPihakKedua(
      OnChangedPihakKedua event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.name = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPihakPertama(
      OnChangedPihakPertama event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.ownerName = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }
}
