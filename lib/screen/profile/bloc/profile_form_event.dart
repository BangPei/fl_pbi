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

class OnChangedFullname extends ProfileFormEvent {
  final String val;
  const OnChangedFullname(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedNik extends ProfileFormEvent {
  final String val;
  const OnChangedNik(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedBirthPlace extends ProfileFormEvent {
  final String val;
  const OnChangedBirthPlace(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedBirthDate extends ProfileFormEvent {
  final DateTime? val;
  const OnChangedBirthDate({this.val});
  @override
  List<Object?> get props => [];
}

class OnChangedGender extends ProfileFormEvent {
  final String val;
  const OnChangedGender(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedBloodGroup extends ProfileFormEvent {
  final String val;
  const OnChangedBloodGroup(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedReligion extends ProfileFormEvent {
  final String val;
  const OnChangedReligion(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedEmail extends ProfileFormEvent {
  final String val;
  const OnChangedEmail(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedPhone extends ProfileFormEvent {
  final String val;
  const OnChangedPhone(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedCurrAddress extends ProfileFormEvent {
  final String val;
  const OnChangedCurrAddress(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedAddress extends ProfileFormEvent {
  final String val;
  const OnChangedAddress(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedSwitch extends ProfileFormEvent {
  final bool val;
  const OnChangedSwitch(this.val);
  @override
  List<Object?> get props => [];
}
