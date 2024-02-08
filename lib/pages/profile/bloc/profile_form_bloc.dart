import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/profile/data/identity_card.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:fl_pbi/pages/profile/data/profile_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

part 'profile_form_event.dart';
part 'profile_form_state.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc() : super(const ProfileFormState()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<OnSubmitProfile>(_onSubmitProfile);
    on<OnChangedFullname>(_onChangedFullname);
    on<OnChangedNik>(_onChangedNik);
    on<OnChangedBirthPlace>(_onChangedBirthPlace);
    on<OnChangedBirthDate>(_onChangedBirthDate);
    on<OnChangedGender>(_onChangedGender);
    on<OnChangedBloodGroup>(_onChangedBloodGroup);
    on<OnChangedReligion>(_onChangedReligion);
    on<OnChangedEmail>(_onChangedEmail);
    on<OnChangedPhone>(_onChangedPhone);
    on<OnChangedCurrAddress>(_onChangedCurrAddress);
    on<OnChangedAddress>(_onChangedAddress);
    on<OnChangedSwitch>(_onChangedSwitch);
    on<OnTappedPicture>(_onTappedPicture);
    on<OnTappedIdentityPicture>(_onTappedIdentityPicture);
  }

  void _onChangedAddress(
      OnChangedAddress event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    IdentityCard identity = profile?.identity ?? IdentityCard();
    identity.address = event.val;
    profile?.identity = identity;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedCurrAddress(
      OnChangedCurrAddress event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.currentAddress = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedPhone(OnChangedPhone event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.phone = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedEmail(OnChangedEmail event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.email = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedReligion(
      OnChangedReligion event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.religion = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onTappedPicture(OnTappedPicture event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.picture = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedBloodGroup(
      OnChangedBloodGroup event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.bloodGroup = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedGender(OnChangedGender event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.gendre = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedBirthDate(
      OnChangedBirthDate event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    if (event.val == null) {
      profile?.birthDate = null;
    } else {
      profile?.birthDate =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    }
    emit(state.copyWith(profile: profile));
  }

  void _onChangedBirthPlace(
      OnChangedBirthPlace event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.birthPlace = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedFullname(
      OnChangedFullname event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    profile?.fullName = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedNik(OnChangedNik event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    IdentityCard identity = profile?.identity ?? IdentityCard();
    identity.idNumber = event.val;
    profile?.identity = identity;
    emit(state.copyWith(profile: profile));
  }

  void _onChangedSwitch(OnChangedSwitch event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    IdentityCard identity = profile?.identity ?? IdentityCard();
    if (event.val) {
      identity.address = profile?.currentAddress;
    } else {
      identity.address = null;
    }
    profile?.identity = identity;
    emit(state.copyWith(profile: profile));
  }

  void _onTappedIdentityPicture(
      OnTappedIdentityPicture event, Emitter<ProfileFormState> emit) {
    Profile? profile = state.profile;
    IdentityCard identity = profile?.identity ?? IdentityCard();
    identity.picture = event.val;
    profile?.identity = identity;
    emit(state.copyWith(profile: profile));
  }

  void _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<ProfileFormState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
      isError: false,
      profile: Profile(),
    ));
    try {
      Profile? profile = await ProfileAPI.getCurrentProfile();
      emit(state.copyWith(isLoading: false, profile: profile));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void _onSubmitProfile(
      OnSubmitProfile event, Emitter<ProfileFormState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      Profile profile = state.profile ?? Profile();
      if (event.image != null) {
        profile.picture = event.image;
      }
      if (event.identity != null) {
        IdentityCard identity = profile.identity ?? IdentityCard();
        identity.picture = event.identity;
        profile.identity = identity;
      }
      Profile newProfile = await ProfileAPI.put(profile.id!, profile);
      await Session.set("profile", jsonEncode(newProfile));
      Session.set("fullName", newProfile.fullName ?? "");
      Session.set("picture", newProfile.picture ?? "");
      emit(state.copyWith(
        isLoading: false,
        profile: newProfile,
        isSuccess: true,
      ));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          profile: state.profile,
          isError: true,
          isSuccess: false,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          profile: state.profile,
          isError: true,
          isSuccess: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
