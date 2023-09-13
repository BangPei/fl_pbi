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
  }

  void _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<ProfileFormState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, isError: false));
    try {
      Profile? profile = await ProfileAPI.getCurrentProfile();
      emit(state.copyWith(isLoading: false, profile: profile));
      state.mappingValue();
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
      state.mappingValue();
    }
  }

  void _onSubmitProfile(
      OnSubmitProfile event, Emitter<ProfileFormState> emit) async {
    // emit(state.copyWith(isLoading: true));
    try {
      Profile newProfile = Profile.fromJson(state.formgroup.value);
      newProfile.id = state.profile?.id;
      newProfile.identity?.id = state.profile?.identity?.id;
      newProfile.user = state.profile?.user;
      Profile? profile = await ProfileAPI.put(newProfile.id!, newProfile);
      await Session.set("fullName", profile.fullName ?? "");
      await Session.set("profile", jsonEncode(profile));
      emit(state.copyWith(
        isLoading: false,
        profile: profile,
        isSuccess: true,
      ));
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
      state.mappingValue();
    }
  }
}
