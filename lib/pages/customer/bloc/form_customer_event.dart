part of 'form_customer_bloc.dart';

abstract class FormCustomerEvent extends Equatable {
  const FormCustomerEvent();
}

class OnInit extends FormCustomerEvent {
  const OnInit();
  @override
  List<Object?> get props => [];
}

class OnChangedName extends FormCustomerEvent {
  final String val;
  const OnChangedName(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedPhone extends FormCustomerEvent {
  final String val;
  const OnChangedPhone(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedEmail extends FormCustomerEvent {
  final String val;
  const OnChangedEmail(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedID extends FormCustomerEvent {
  final String val;
  const OnChangedID(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedBirthPlace extends FormCustomerEvent {
  final String val;
  const OnChangedBirthPlace(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedGender extends FormCustomerEvent {
  final String val;
  const OnChangedGender(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedBlood extends FormCustomerEvent {
  final String val;
  const OnChangedBlood(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedReligion extends FormCustomerEvent {
  final String val;
  const OnChangedReligion(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedAddress extends FormCustomerEvent {
  final String val;
  const OnChangedAddress(this.val);
  @override
  List<Object?> get props => [];
}

class OnAddCompany extends FormCustomerEvent {
  final Company val;
  const OnAddCompany(this.val);
  @override
  List<Object?> get props => [];
}

class OnChangedDate extends FormCustomerEvent {
  final DateTime val;
  const OnChangedDate(this.val);
  @override
  List<Object?> get props => [];
}

class OnSubmit extends FormCustomerEvent {
  const OnSubmit();
  @override
  List<Object?> get props => [];
}
