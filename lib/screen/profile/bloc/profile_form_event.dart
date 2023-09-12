part of 'profile_form_bloc.dart';

abstract class ProfileFormEvent extends Equatable {
  const ProfileFormEvent();
}

class GetCurrentUserEvent extends ProfileFormEvent {
  const GetCurrentUserEvent();
  @override
  List<Object?> get props => [];
}

class OnSubmitProfile extends ProfileFormEvent {
  const OnSubmitProfile();
  @override
  List<Object?> get props => [];
}

class OnFirstNameChanged extends ProfileFormEvent {
  final String val;
  const OnFirstNameChanged(this.val);
  @override
  List<Object?> get props => [];
}

class OnLastNameChanged extends ProfileFormEvent {
  final String val;
  const OnLastNameChanged(this.val);
  @override
  List<Object?> get props => [val];
}

class OnEmailChanged extends ProfileFormEvent {
  final String val;
  const OnEmailChanged(this.val);
  @override
  List<Object?> get props => [val];
}

class OnPhoneChanged extends ProfileFormEvent {
  final String val;
  const OnPhoneChanged(this.val);
  @override
  List<Object?> get props => [val];
}

class OnCurrAddressChanged extends ProfileFormEvent {
  final String val;
  const OnCurrAddressChanged(this.val);
  @override
  List<Object?> get props => [val];
}
