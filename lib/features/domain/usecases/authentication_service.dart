import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthenticationService.instance({required this.auth}) {
    auth.authStateChanges();
  }

  AuthenticationService();

  Future createUser({required String email, required String password}) async {
    try {
      var authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        FirebaseCrashlytics.instance.setCustomKey('email-already-in-use', e);
      }
      throw Exception(e.code);
    }
  }

  Future loginUser({required String email, required String password}) async {
    try {
      var authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        FirebaseCrashlytics.instance.setCustomKey('invalid-email', e);
      }
      throw Exception(e.code);
    }
  }

  //Test
  Future test({required String email}) async {
    try {
      Text("Olá, meu caro $email");
      return true;
    } catch (e) {
      return false;
    }
  }
}
