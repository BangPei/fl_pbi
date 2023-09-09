import 'package:dio/dio.dart';
import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/screen/login/data/login.dart';
import 'package:fl_pbi/screen/login/data/login_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'login_event.dart';
part 'login_state.dart';

final NavigationService _nav = locator<NavigationService>();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLoginSubmit>(_onLoginSubmit);
  }

  void _onLoginSubmit(OnLoginSubmit event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      BuildContext context = _nav.navKey.currentContext!;
      Login login = event.login;
      var dataLOgin = await LoginApi.login(login);
      await Future.wait([
        Session.set("token", dataLOgin["token"]),
        Session.set("fullName", dataLOgin["profile"]["fullName"]),
        Session.set("picture", dataLOgin["profile"]?["picture"] ?? ""),
      ]);
      // ignore: use_build_context_synchronously
      context.go('/');
    } catch (e) {
      DioError err = e as DioError;
      emit(LoginErrorState(errorMessage: err.message));
    }
  }
}
