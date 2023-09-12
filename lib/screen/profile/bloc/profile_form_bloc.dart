import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:fl_pbi/screen/profile/data/profile_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_form_event.dart';
part 'profile_form_state.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc() : super(const ProfileFormState()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  void _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<ProfileFormState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      Profile? profile = await ProfileAPI.getCurrentProfile();
      emit(state.copyWith(isLoading: false, isError: false, profile: profile));
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
