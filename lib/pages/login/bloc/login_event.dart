part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class OnLoginSubmit extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class OnChangeUsername extends LoginEvent {
  final String username;
  const OnChangeUsername(this.username);
  @override
  List<Object?> get props => [username];
}

class OnChangePassword extends LoginEvent {
  final String password;
  const OnChangePassword(this.password);
  @override
  List<Object?> get props => [password];
}
