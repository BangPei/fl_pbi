import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/models/customer.dart';
import 'package:fl_pbi/models/hak_guna.dart';
import 'package:fl_pbi/models/kios.dart';
import 'package:fl_pbi/models/pic.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

part 'tanda_hak_guna_event.dart';
part 'tanda_hak_guna_state.dart';

NavigationService _nav = locator<NavigationService>();

class TandaHakGunaBloc extends Bloc<TandaHakGunaEvent, TandaHakGunaState> {
  TandaHakGunaBloc() : super(const TandaHakGunaState()) {
    on<OnSubmit>(_onSubmit);
    on<OnSubmitTemplate>(_onSubmitTemplate);
    on<OnInit>(_onInit);
    on<OnChangedNoPerjanjian>(_onChangedNoPerjanjian);
    on<OnChangedTempatDibuat>(_onChangedTempatDibuat);
    on<OnChangedTanggalDibuat>(_onChangedTanggalDibuat);
    on<OnChangedNamaPihakPertama>(_onChangedNamaPihakPertama);
    on<OnChangedDOBPihakPertama>(_onChangedDOBPihakPertama);
    on<OnChangedNikPihakPertama>(_onChangedNikPihakPertama);
    on<OnChangedPhonePihakPertama>(_onChangedPhonePihakPertama);
    on<OnChangedJobPihakPertama>(_onChangedJobPihakPertama);
    on<OnChangedAddressPihakPertama>(_onChangedAddressPihakPertama);
    on<OnChangedNamePihakKedua>(_onChangedNamePihakKedua);
    on<OnChangedNikPihakKedua>(_onChangedNikPihakKedua);
    on<OnChangedAddressPihakKedua>(_onChangedAddressPihakKedua);
    on<OnChangedLocation>(_onChangedLocation);
    on<OnChangedBlock>(_onChangedBlock);
    on<OnChangedBlockNo>(_onChangedBlockNo);
    on<OnChangedJumlahKios>(_onChangedJumlahKios);
    on<OnChangedMasaBerlaku>(_onChangedMasaBerlaku);
    on<OnChangedNomorSurat>(_onChangedNomorSurat);
  }

  void _onInit(OnInit event, Emitter<TandaHakGunaState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? strProfile = await Session.get('profile');
      Profile profile = await Common.getProfileSession(strProfile ?? "{}");
      HakGuna? hakGuna = await Common.getHakGuna(profile);
      // Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(hakGuna: hakGuna, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmit(OnSubmit event, Emitter<TandaHakGunaState> emit) async {
    try {
      HakGuna? hakGuna = state.hakGuna;
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": hakGuna,
        "pdf": hakGuna!.tandaDaftarPdf(),
        "title":
            "Tanda Daftar Hak Guna ${DateTime.now().millisecond.toString()}"
      });
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmitTemplate(
      OnSubmitTemplate event, Emitter<TandaHakGunaState> emit) async {
    try {
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": HakGuna(),
        "pdf": HakGuna().tandaDaftarPdf(),
        "title":
            "Tanda Daftar Hak Guna ${DateTime.now().millisecond.toString()}"
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onChangedNoPerjanjian(
      OnChangedNoPerjanjian event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.noHakGuna = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNomorSurat(
      OnChangedNomorSurat event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    // hakGuna?.no = event.val;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedTempatDibuat(
      OnChangedTempatDibuat event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    hakGuna?.createdPlace = event.val;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedTanggalDibuat(
      OnChangedTanggalDibuat event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    if (event.val != null) {
      hakGuna?.createdAt =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      hakGuna?.createdAt = null;
    }
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNamaPihakPertama(
      OnChangedNamaPihakPertama event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.name = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNikPihakPertama(
      OnChangedNikPihakPertama event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.nik = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedDOBPihakPertama(
      OnChangedDOBPihakPertama event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    if (event.val != null) {
      pic.dateBirth =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      pic.dateBirth = null;
    }
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedPhonePihakPertama(
      OnChangedPhonePihakPertama event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.phone = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedJobPihakPertama(
      OnChangedJobPihakPertama event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.job = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedAddressPihakPertama(
      OnChangedAddressPihakPertama event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.address = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNamePihakKedua(
      OnChangedNamePihakKedua event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.name = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNikPihakKedua(
      OnChangedNikPihakKedua event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.nik = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedAddressPihakKedua(
      OnChangedAddressPihakKedua event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.address = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedLocation(
      OnChangedLocation event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.location = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedBlock(OnChangedBlock event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.block = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedBlockNo(
      OnChangedBlockNo event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.blockNo = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedJumlahKios(
      OnChangedJumlahKios event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.totalKios = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedMasaBerlaku(
      OnChangedMasaBerlaku event, Emitter<TandaHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    if (event.val != null) {
      kios.endDate =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      kios.endDate = null;
    }
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }
}
