import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:xrpay/features/authentication/data/data_source/auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource{

  final FirebaseAuth _firebaseAuth;

  AuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<User> signUp({required String name, required String email, required String password}) async {
    try {
      final UserCredential response = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseAuth.currentUser!.updateDisplayName(name);
      log("Response: ${response.user.toString()}");
      return response.user!;
    } catch(error) {

      throw error;
    }
  }

}