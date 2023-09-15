import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:fl_pbi/screen/profile/data/profile_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

part 'profile_form_event.dart';
part 'profile_form_state.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc() : super(const ProfileFormState()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<OnSubmitProfile>(_onSubmitProfile);
  }

  void _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<ProfileFormState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, isError: false));
    try {
      Profile? profile = await ProfileAPI.getCurrentProfile();
      profile.birthDate =
          Jiffy.parse(profile.birthDate ?? "").format(pattern: "dd MMMM yyyy");
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
      // Profile newProfile = Profile.fromJson(state.formgroup.value);
      // newProfile.id = state.profile?.id;
      // newProfile.identity?.id = state.profile?.identity?.id;
      // newProfile.user = state.profile?.user;
      // newProfile.birthDate =
      //     Jiffy.parse(newProfile.birthDate ?? "", pattern: "dd MMMM yyyy")
      //         .format(pattern: "yyyy-MM-dd");
      // emit(state.copyWith(profile: newProfile));
      // Profile? profile =
      //     await ProfileAPI.put(newProfile.id!, state.profile ?? newProfile);
      // emit(state.copyWith(isSuccess: true));
      // await Session.set("fullName", profile.fullName ?? "");
      // await Session.set("profile", jsonEncode(profile));
      // profile.birthDate =
      //     Jiffy.parse(profile.birthDate ?? "").format(pattern: "dd MMMM yyyy");
      // emit(
      //     state.copyWith(isLoading: false, profile: profile, isSuccess: false));
    } catch (e) {
      // if (e.runtimeType == DioException) {
      //   DioException err = e as DioException;
      //   emit(state.copyWith(
      //     isLoading: false,
      //     profile: state.profile,
      //     isError: true,
      //     isSuccess: false,
      //     errorMessage: err.response?.data?["message"] ?? err.message,
      //   ));
      // } else {
      //   emit(state.copyWith(
      //     isLoading: false,
      //     profile: state.profile,
      //     isError: true,
      //     isSuccess: false,
      //     errorMessage: e.toString(),
      //   ));
      // }
      // state.mappingValue();
    }
  }
}
