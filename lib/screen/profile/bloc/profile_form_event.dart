part of 'profile_form_bloc.dart';

abstract class ProfileFormEvent extends Equatable {
  const ProfileFormEvent();
}

class GetCurrentUserEvent extends ProfileFormEvent {
  const GetCurrentUserEvent();
  @override
  List<Object?> get props => [];
}
