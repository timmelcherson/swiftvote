import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<Map<String, dynamic>> signInWithCredentials({String email, String password}) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {'success': true, 'value': credential};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'value': e.message};
    }
  }

  Future<Map<String, dynamic>> signUp({String email, String password}) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {'success': true, 'value': credential};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'value': e.message};
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
