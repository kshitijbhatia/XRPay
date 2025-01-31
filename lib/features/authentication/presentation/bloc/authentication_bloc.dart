import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:xrpay/core/network/network_error.dart';
import 'package:xrpay/features/authentication/domain/usecases/signup.dart';
import 'package:xrpay/features/authentication/domain/usecases/login.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;

  AuthenticationBloc(this._signUpUseCase, this._loginUseCase) : super(const AuthenticationState()) {
    on<UpdateNameEvent>(updateName);
    on<UpdateEmailEvent>(updateEmail);
    on<UpdatePasswordEvent>(updatePassword);
    on<HideShowPasswordEvent>(updateObscureText);
    on<SignUpEvent>(userSignUp);
    on<ResetAuthStateEvent>(resetAuthState);
    on<LoginEvent>(userLogin);
  }

  updateName(UpdateNameEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      name: event.name,
      isFormValid: _isFormValid(name: event.name, state.password, state.email)
    ));
  }

  updateEmail(UpdateEmailEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      email: event.email,
      isFormValid: _isFormValid(name: state.name, state.password, event.email),
    ));
  }

  updatePassword(UpdatePasswordEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      password: event.password,
      isFormValid: _isFormValid(name: state.name, event.password, state.email)
    ));
  }

  updateObscureText(HideShowPasswordEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  bool _isValidName(String name) {
    if(name.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool _isValidEmail(String email) {
    if(email.isNotEmpty && RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return true;
    }
    return false;
  }

  bool _isValidPassword(String password) {
    if(password.isNotEmpty && password.length >= 8) {
      return true;
    }
    return false;
  }

  bool _isFormValid(String password, String email, {String name = ""}) {
    final bool validEmail = _isValidEmail(email);
    final bool validPassword = _isValidPassword(password);
    bool validName = true;
    if(name != "") validName = _isValidName(name);

    return validName && validPassword && validEmail;
  }

  void userSignUp(SignUpEvent event,Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading, error: null));
      SignUpParams signUpParams = SignUpParams(name: state.name, email: state.email, password: state.password);
      await _signUpUseCase(signUpParams);
      emit(state.copyWith(status: AuthenticationStatus.success, error: null));
    } on DataException catch(error) {
      log("***auth_signup_bloc: ${error.message}");
      emit(state.copyWith(status: AuthenticationStatus.error, error: error.message));
    }
  }

  void userLogin(LoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading, error: null));
      LoginParams loginParams = LoginParams(email: state.email, password: state.password);
      await _loginUseCase(loginParams);
      emit(state.copyWith(status: AuthenticationStatus.success, error: null));
    } on DataException catch(error) {
      log("***auth_login_bloc: ${error.message}");
      emit(state.copyWith(status: AuthenticationStatus.error, error: error.message));
    }
  }

  resetAuthState(ResetAuthStateEvent event, Emitter<AuthenticationState> emit) {
    emit(const AuthenticationState());
  }
}