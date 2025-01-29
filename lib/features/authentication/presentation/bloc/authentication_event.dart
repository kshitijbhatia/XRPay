part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class UpdateNameEvent extends AuthenticationEvent {
  final String name;

  UpdateNameEvent(this.name);
}

class UpdateEmailEvent extends AuthenticationEvent {
  final String email;

  UpdateEmailEvent(this.email);
}

class UpdatePasswordEvent extends AuthenticationEvent {
  final String password;

  UpdatePasswordEvent(this.password);
}

class HideShowPasswordEvent extends AuthenticationEvent{}

class SignUpEvent extends AuthenticationEvent {}