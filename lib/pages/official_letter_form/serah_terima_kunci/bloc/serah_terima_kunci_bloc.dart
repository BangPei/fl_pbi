import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/inject_file.dart';
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/block/data/block_api.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

part 'serah_terima_kunci_event.dart';
part 'serah_terima_kunci_state.dart';

NavigationService _nav = locator<NavigationService>();

class SerahTerimaKunciBloc
    extends Bloc<SerahTerimaKunciEvent, SerahTerimaKunciState> {
  SerahTerimaKunciBloc() : super(const SerahTerimaKunciState()) {
    on<OnChangedSignPlace>(_onChangedSignPlace);
    on<OnChangedDate>(_onChangedDate);
    on<OnChangedNamePihakPertama>(_onChangedNamePihakPertama);
    on<OnChangedNikPihakPertama>(_onChangedNikPihakPertama);
    on<OnChangedPhonePihakPertama>(_onChangedPhonePihakPertama);
    on<OnChangedPosition>(_onChangedPosition);
    on<OnChangedAddressPihakPertama>(_onChangedAddressPihakPertama);
    on<OnChangedNamePihakKedua>(_onChangedNamePihakKedua);
    on<OnChangedNikPihakKedua>(_onChangedNikPihakKedua);
    on<OnChangedPhonePihakKedua>(_onChangedPhonePihakKedua);
    on<OnChangedAddressPihakKedua>(_onChangedAddressPihakKedua);
    on<OnChangedBlokKios>(_onChangedBlokKios);
    on<OnInit>(_onInit);
    on<OnSubmit>(_onSubmit);
    on<OnSubmitTemplate>(_onSubmitTemplate);
  }

  void _onChangedSignPlace(
      OnChangedSignPlace event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    hakGuna.createdPlace = event.val;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedDate(
      OnChangedDate event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    if (event.val != null) {
      hakGuna.createdAt =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      hakGuna.createdAt = null;
    }
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNamePihakPertama(
      OnChangedNamePihakPertama event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Pic pic = hakGuna.pic ?? Pic();
    pic.name = event.val;
    hakGuna.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNikPihakPertama(
      OnChangedNikPihakPertama event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Pic pic = hakGuna.pic ?? Pic();
    pic.nik = event.val;
    hakGuna.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedPhonePihakPertama(
      OnChangedPhonePihakPertama event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Pic pic = hakGuna.pic ?? Pic();
    pic.phone = event.val;
    hakGuna.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedPosition(
      OnChangedPosition event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Pic pic = hakGuna.pic ?? Pic();
    pic.job = event.val;
    hakGuna.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedAddressPihakPertama(
      OnChangedAddressPihakPertama event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Pic pic = hakGuna.pic ?? Pic();
    pic.address = event.val;
    hakGuna.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNamePihakKedua(
      OnChangedNamePihakKedua event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Customer customer = hakGuna.customer ?? Customer();
    customer.name = event.val;
    hakGuna.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNikPihakKedua(
      OnChangedNikPihakKedua event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Customer customer = hakGuna.customer ?? Customer();
    customer.nik = event.val;
    hakGuna.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedPhonePihakKedua(
      OnChangedPhonePihakKedua event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Customer customer = hakGuna.customer ?? Customer();
    customer.phone = event.val;
    hakGuna.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedAddressPihakKedua(
      OnChangedAddressPihakKedua event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Customer customer = hakGuna.customer ?? Customer();
    customer.address = event.val;
    hakGuna.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedBlokKios(
      OnChangedBlokKios event, Emitter<SerahTerimaKunciState> emit) {
    HakGuna? hakGuna = state.hakGuna ?? HakGuna();
    Kios kios = hakGuna.kios ?? Kios();
    kios.block = event.val;
    hakGuna.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onInit(OnInit event, Emitter<SerahTerimaKunciState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      List<BlockDetail> blockDetails = await BlockApi.getBlockDetails();
      String? strProfile = await Session.get('profile');
      Profile profile = await Common.getProfileSession(strProfile ?? "{}");
      HakGuna? hakGuna = await Common.getHakGuna(profile);
      emit(state.copyWith(
          hakGuna: hakGuna, isLoading: false, blockDetails: blockDetails));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmit(OnSubmit event, Emitter<SerahTerimaKunciState> emit) async {
    try {
      HakGuna? hakGuna = state.hakGuna ?? HakGuna();
      hakGuna.kios = hakGuna.kios ?? Kios();
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": hakGuna,
        "pdf": hakGuna.serahTerimaPdf(),
        "title":
            "Surat Serah Terima Kunci ${DateTime.now().millisecond.toString()}"
      });
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmitTemplate(
      OnSubmitTemplate event, Emitter<SerahTerimaKunciState> emit) async {
    try {
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": HakGuna(),
        "pdf": HakGuna().serahTerimaPdf(),
        "title":
            "Surat Serah Terima Kunci ${DateTime.now().millisecond.toString()}"
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
