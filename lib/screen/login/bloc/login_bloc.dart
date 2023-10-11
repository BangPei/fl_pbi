import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/screen/login/data/login.dart';
import 'package:fl_pbi/screen/login/data/login_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retrofit/dio.dart';

part 'login_event.dart';
part 'login_state.dart';

final NavigationService _nav = locator<NavigationService>();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnLoginSubmit>(_onLoginSubmit);
    on<OnChangePassword>(_onChangePassword);
    on<OnChangeUsername>(_onChangeUsername);
  }

  void _onChangePassword(OnChangePassword event, Emitter<LoginState> emit) {
    final password = event.password;
    emit(state.copyWith(password: password));
  }

  void _onChangeUsername(OnChangeUsername event, Emitter<LoginState> emit) {
    final username = event.username;
    emit(state.copyWith(username: username));
  }

  void _onLoginSubmit(OnLoginSubmit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      BuildContext context = _nav.navKey.currentContext!;

      Login? login = Login(password: state.password, username: state.username);

      HttpResponse resp = await LoginApi.login(login);
      var data = resp.data;
      var header = resp.response.headers;
      var token = header['authorization'];
      await Future.wait([
        Session.set("token", token?[0] ?? ""),
        Session.set("username", data['user']["username"]),
        Session.set("profile", jsonEncode(data)),
        Session.set("fullName", data["fullName"]),
        Session.set("picture", data["picture"] ?? ""),
      ]);
      // ignore: use_build_context_synchronously
      context.go('/surat-resmi');
      emit(state.copyWith(isLoading: false, isError: false));
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
}
