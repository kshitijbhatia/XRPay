import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:xrpay/features/authentication/data/data_source/auth_data_source.dart';
import 'package:xrpay/features/authentication/domain/repository/auth_repo.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<void> userSignUp({required String name,required String email,required String password}) async {
    try {
      final User response = await _authDataSource.signUp(name: name, email: email, password: password);
    } catch(error) {
      log("***userSignUp_repo: ${error.toString()}");
    }
  }

}