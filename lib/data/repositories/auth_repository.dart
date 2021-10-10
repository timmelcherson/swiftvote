import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/responses/BaseResponse.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository() : _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Signs in the user with a custom [token].
  ///
  /// The custom token should be the device unique identifier in this case.
  /// Returns a [BaseResponse] the created user's firebase auth UID on success.
  Future<BaseResponse> signInWithCustomToken({@required String token}) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithCustomToken(token);
      return BaseResponse(success: true, value: credential.user.uid);
    } on FirebaseAuthException catch (e) {
      return BaseResponse(success: false, value: e.message);
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
