import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(String email, String password) async {
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    log("User Register: Success $userCredential");
    return userCredential;
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      log("User Login: Success $userCredential");
      return userCredential;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
