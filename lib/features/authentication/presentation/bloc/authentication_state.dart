part of 'authentication_bloc.dart';

@immutable
class AuthenticationState extends Equatable{
  final String name;
  final String email;
  final String password;
  final bool isFormValid;
  final bool obscureText;
  final String? error;
  final AuthenticationStatus status;

  const AuthenticationState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.isFormValid = false,
    this.obscureText = true,
    this.error,
    this.status = AuthenticationStatus.initial
  });

  AuthenticationState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isFormValid,
    bool? obscureText,
    String? error,
    AuthenticationStatus? status
  }) {
    return AuthenticationState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isFormValid: isFormValid ?? this.isFormValid,
      obscureText: obscureText ?? this.obscureText,
      error: error ?? this.error,
      status: status ?? this.status
    );
  }

  @override
  List<Object?> get props => [name, email, password, isFormValid, obscureText, error, status];
}

enum AuthenticationStatus {
  initial,
  loading,
  success,
  error
}