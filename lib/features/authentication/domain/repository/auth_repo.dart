abstract class AuthRepository {
  Future<void> userSignUp({required String name,required String email,required String password});

  Future<void> userLogin({required String email, required String password});
}