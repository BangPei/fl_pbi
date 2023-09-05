part of 'login_bloc.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class LoginErrorState extends LoginState {
  List<Object?> get props => [];
}

final class LoginLoadingState extends LoginState {
  List<Object?> get props => [];
}

class LoginSubmitState extends LoginState {
  final String username;
  final String password;
  final String firstName;
  const LoginSubmitState(
      {required this.username,
      required this.password,
      required this.firstName});
  LoginSubmitState copyWith({username, password, firstname}) {
    return LoginSubmitState(
      firstName: firstName,
      password: password,
      username: username ?? this.username,
    );
  }

  List<Object?> get props => [username, password, firstName];
}
