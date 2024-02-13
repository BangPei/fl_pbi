import 'package:equatable/equatable.dart';
import 'package:fl_pbi/pages/company/data/company.dart';
import 'package:fl_pbi/pages/profile/data/identity_card.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

part 'form_customer_event.dart';
part 'form_customer_state.dart';

class FormCustomerBloc extends Bloc<FormCustomerEvent, FormCustomerState> {
  FormCustomerBloc() : super(const FormCustomerState()) {
    on<OnInit>(_onInit);
    on<OnChangedName>(_onChangedName);
    on<OnChangedPhone>(_onChangedPhone);
    on<OnChangedEmail>(_onChangedEmail);
    on<OnChangedID>(_onChangedID);
    on<OnChangedBirthPlace>(_onChangedBirthPlace);
    on<OnChangedDate>(_onChangedDate);
    on<OnChangedGender>(_onChangedGender);
    on<OnChangedBlood>(_onChangedBlood);
    on<OnChangedReligion>(_onChangedReligion);
    on<OnChangedAddress>(_onChangedAddress);
    on<OnAddCompany>(_onAddCompany);
  }

  void _onChangedDate(OnChangedDate event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.birthDate =
        Jiffy.parseFromDateTime(event.val).format(pattern: "yyyy-MM-dd");
    emit(state.copyWith(customer: customer));
  }

  void _onAddCompany(OnAddCompany event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    List<Company> companies = customer.companies ?? [];
    companies.add(event.val);
    customer.companies = companies;
    emit(state.copyWith(customer: customer));
  }

  void _onInit(OnInit event, Emitter<FormCustomerState> emit) {
    emit(state.copyWith(customer: Profile(), isError: false, isLoading: false));
  }

  void _onChangedName(OnChangedName event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.fullName = event.val;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedPhone(OnChangedPhone event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.phone = event.val;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedEmail(OnChangedEmail event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.email = event.val;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedID(OnChangedID event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    IdentityCard identity = state.customer?.identity ?? IdentityCard();
    identity.idNumber = event.val;
    customer.identity = identity;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedBirthPlace(
      OnChangedBirthPlace event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.birthPlace = event.val;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedGender(
      OnChangedGender event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.gendre = event.val;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedBlood(OnChangedBlood event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.bloodGroup = event.val;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedReligion(
      OnChangedReligion event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.religion = event.val;
    emit(state.copyWith(customer: customer));
  }

  void _onChangedAddress(
      OnChangedAddress event, Emitter<FormCustomerState> emit) {
    Profile customer = state.customer ?? Profile();
    customer.currentAddress = event.val;
    IdentityCard identityCard = customer.identity ?? IdentityCard();
    identityCard.address = event.val;
    customer.identity = identityCard;
    emit(state.copyWith(customer: customer));
  }
}
