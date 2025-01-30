import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:xrpay/features/authentication/domain/usecases/signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final SignUpUseCase _signUpUseCase;

  AuthenticationBloc(this._signUpUseCase) : super(const AuthenticationState()) {
    on<UpdateNameEvent>(updateName);
    on<UpdateEmailEvent>(updateEmail);
    on<UpdatePasswordEvent>(updatePassword);
    on<HideShowPasswordEvent>(updateObscureText);
    on<SignUpEvent>(userSignUp);
  }

  updateName(UpdateNameEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      name: event.name,
      isFormValid: _isFormValid(event.name, state.password, state.email)
    ));
  }

  updateEmail(UpdateEmailEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      email: event.email,
      isFormValid: _isFormValid(state.name, state.password, event.email),
    ));
  }

  updatePassword(UpdatePasswordEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      password: event.password,
      isFormValid: _isFormValid(state.name, event.password, state.email)
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

  bool _isFormValid(String name, String password, String email) {
    if(!_isValidEmail(email) || !_isValidName(name) || !_isValidPassword(password)) {
      return false;
    }
    return true;
  }

  void userSignUp(SignUpEvent event,Emitter<AuthenticationState> emit) async {
    try {
      SignUpParams signUpParams = SignUpParams(name: state.name, email: state.email, password: state.password);
      await _signUpUseCase(signUpParams);
    } catch(error) {
      log("***auth_bloc: $error");
    }
  }
}
