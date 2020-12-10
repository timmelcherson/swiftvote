import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signInWithCredentials({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print('USER SIGNED UP');
      return 'success';
    } on FirebaseAuthException catch (e) {
      print('REGISTRATION FAILURE');
      print(e.message);
      return e.message;
    }
  }

  Future<bool> isSignedIn() async {
    print('USER SIGNED IN? ${_firebaseAuth.currentUser != null}');
    return _firebaseAuth.currentUser != null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
