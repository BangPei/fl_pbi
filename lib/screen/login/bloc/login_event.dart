part of 'login_bloc.dart';

abstract class LoginEvent {
  LoginEvent();
}

class OnLoginSubmit extends LoginEvent {
  Login login;
  OnLoginSubmit(this.login);
}
