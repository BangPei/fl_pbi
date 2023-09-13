import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:fl_pbi/screen/profile/data/profile_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'profile_form_event.dart';
part 'profile_form_state.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc() : super(ProfileFormState()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<OnSubmitProfile>(_onSubmitProfile);
    on<OnFirstNameChanged>(_onFirstNameChanged);
    on<OnLastNameChanged>(_onLastNameChanged);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPhoneChanged>(_onPhoneChanged);
    on<OnCurrAddressChanged>(_onCurrAddressChanged);
  }

  void _onFirstNameChanged(
      OnFirstNameChanged event, Emitter<ProfileFormState> emit) {
    Profile profile = state.profile ?? Profile();
    profile.firstName = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onLastNameChanged(
      OnLastNameChanged event, Emitter<ProfileFormState> emit) {
    Profile profile = state.profile ?? Profile();
    profile.lastName = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onEmailChanged(OnEmailChanged event, Emitter<ProfileFormState> emit) {
    Profile profile = state.profile ?? Profile();
    profile.email = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onPhoneChanged(OnPhoneChanged event, Emitter<ProfileFormState> emit) {
    Profile profile = state.profile ?? Profile();
    profile.phone = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onCurrAddressChanged(
      OnCurrAddressChanged event, Emitter<ProfileFormState> emit) {
    Profile profile = state.profile ?? Profile();
    profile.currentAddress = event.val;
    emit(state.copyWith(profile: profile));
  }

  void _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<ProfileFormState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, isError: false));
    try {
      Profile? profile = await ProfileAPI.getCurrentProfile();
      emit(state.copyWith(isLoading: false, profile: profile));
      state.mappingValue();
    } catch (e) {
      DioException err = e as DioException;
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: err.response?.data?["message"] ?? err.message,
      ));
    }
  }

  void _onSubmitProfile(
      OnSubmitProfile event, Emitter<ProfileFormState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      Profile? profile =
          await ProfileAPI.put(state.profile!.id!, state.profile!);
      await Session.set("fullName", profile.fullName ?? "");
      await Session.set("profile", jsonEncode(profile));
      emit(state.copyWith(
        isLoading: false,
        profile: profile,
        isSuccess: true,
      ));
    } catch (e) {
      DioException err = e as DioException;
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: err.response?.data?["message"] ?? err.message,
      ));
    }
  }
}
