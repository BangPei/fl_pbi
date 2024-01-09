part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.username,
    this.password,
    this.errorMessage,
    this.isLoading = false,
    this.isError = false,
  });

  final String? username;
  final String? password;
  final String? errorMessage;
  final bool isLoading;
  final bool isError;

  LoginState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    String? errorMessage,
    bool? isError,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, username, password, isError, errorMessage];
}
