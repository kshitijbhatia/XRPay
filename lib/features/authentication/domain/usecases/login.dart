import 'dart:developer';

import 'package:xrpay/config/common/usecase.dart';
import 'package:xrpay/core/network/network_error.dart';
import 'package:xrpay/features/authentication/domain/repository/auth_repo.dart';

class LoginUseCase extends UseCase<void, LoginParams> {

  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<void> call(LoginParams params) async {
    try {
      await _authRepository.userLogin(email: params.email, password: params.password);
    } catch(error) {
      if(error is DataException) {
        rethrow;
      }
      log("***login_usecase: $error");
      throw DataException(error.toString());
    }
  }

}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}