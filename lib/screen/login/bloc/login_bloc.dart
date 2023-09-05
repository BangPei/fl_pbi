import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/screen/login/data/login.dart';
import 'package:fl_pbi/screen/login/data/login_api.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

final NavigationService _nav = locator<NavigationService>();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLoginSubmit>(_onLoginSubmit);
  }

  void _onLoginSubmit(OnLoginSubmit event, Emitter<LoginState> emit) async {
    // emit(ProductLoadingDialogState());
    try {
      // BuildContext context = _nav.navKey.currentContext!;
      Login login = event.login;
      var dataLOgin = await LoginApi.login(login);
      print(dataLOgin);
    } catch (e) {
      emit(LoginErrorState());
    }
  }
}
