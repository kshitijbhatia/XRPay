import 'dart:developer';

import 'package:xrpay/config/common/usecase.dart';
import 'package:xrpay/features/authentication/domain/repository/auth_repo.dart';

class SignUpUseCase extends UseCase<void, SignUpParams> {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<void> call(SignUpParams params) async {
    try {
      await _authRepository.userSignUp(name: params.name, email: params.email, password: params.password);
    } catch(error) {
      log("***signUp_usecase: $error");
    }
  }

}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password
  });
}