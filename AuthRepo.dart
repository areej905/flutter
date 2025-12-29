import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_shop/data/repos/AuthRepo.dart';

class AuthRepo {
  Future<UserCredential> login(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
  Future<UserCredential> signup(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),

    );
  }
  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      throw FirebaseAuthException(
        code: 'empty-email',
        message: 'Please enter your email',
      );
    }
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }
}