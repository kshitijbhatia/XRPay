import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<User> signUp({required String name, required String email,required String password});
}