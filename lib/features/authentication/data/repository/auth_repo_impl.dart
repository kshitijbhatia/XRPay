import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:xrpay/core/network/network_error.dart';
import 'package:xrpay/features/authentication/data/data_source/auth_data_source.dart';
import 'package:xrpay/features/authentication/data/model/user_model.dart';
import 'package:xrpay/features/authentication/domain/repository/auth_repo.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<void> userSignUp({required String name,required String email,required String password}) async {
    try {
      final User response = await _authDataSource.signUp(name: name, email: email, password: password);
      final Map<String, dynamic> responseJson = {
        "id": response.uid,
        "name": name,
        "email": response.email,
      };
      final UserModel user = UserModel.fromJson(responseJson);
    } catch(error) {
      if(error is DataException) {
        rethrow;
      }
      log("***userSignUp_repo: ${error.toString()}");
      throw DataException(error.toString());
    }
  }

  @override
  Future<void> userLogin({required String email, required String password}) async {
    try {
      final User response = await _authDataSource.login(email: email, password: password);
      // final Map<String, dynamic> responseJson = {
      //   "id": response.uid,
      //   "name":
      // }
    } catch(error) {
      if(error is DataException) {
        rethrow;
      }
      log("***userLoginIn_repo: ${error.toString()}");
      throw DataException(error.toString());
    }
  }
}