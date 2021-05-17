import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({
    @required this.userRepository,
  }) : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogInEvent) {
      yield* _mapAuthLogInEventToState(event);
    } else if (event is AuthLogOutEvent) {
      yield* _mapAuthLogOutEventToState();
    }
  }

  Stream<AuthState> _mapAuthLogInEventToState(AuthLogInEvent event) async* {

    var result = await userRepository.signInWithCredentials(email: event.email, password: event.password);

    print('LOGIN RESULT');
    print(result);

    if (result['success']) {
      print('_mapAuthLogInEventToState SUCCESSFUL');
      yield AuthSuccessState(user:  (result['value'] as UserCredential).user);
    } else {
      yield AuthFailState(errorMessage: result['value'].toString());
    }
  }

  Stream<AuthState> _mapAuthLogOutEventToState() async* {
    yield AuthFailState();
    userRepository.signOut();
  }
}
