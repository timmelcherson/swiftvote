import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/data/repositories/index.dart';
import 'package:swiftvote/data/repositories/auth_repository.dart';
import 'index.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  // AuthBloc({
  //   @required this.authRepository,
  // }) : super(AuthInitialState());

  final RegisterBloc registerBloc;
  StreamSubscription registerSubscription;

  AuthBloc({@required this.authRepository, @required this.registerBloc})
      : super(AuthLoadingState()) {
    registerSubscription = registerBloc.stream.listen((RegisterState state) {
      if (state is RegisterSuccessState) {}
    });
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // if (event is AuthLogInEvent) {
    //   yield* _mapAuthLogInEventToState(event);
    // }
    // else if (event is AuthLogOutEvent) {
    //   yield* _mapAuthLogOutEventToState();
    // }
  }

  // Stream<AuthState> _mapAuthLogInEventToState(AuthLogInEvent event) async* {
  //   var result = await authRepository.signInWithCredentials(
  //       email: event.email, password: event.password);
  //
  //   print('LOGIN RESULT');
  //   print(result);
  //
  //   if (result['success']) {
  //     print('_mapAuthLogInEventToState SUCCESSFUL');
  //     yield AuthSuccessState(user: (result['value'] as UserCredential).user);
  //   } else {
  //     yield AuthFailState(errorMessage: result['value'].toString());
  //   }
  // }

  // Stream<AuthState> _mapAuthLogOutEventToState() async* {
  //   yield AuthFailState();
  //   authRepository.signOut();
  // }

  @override
  Future<Function> close() {
    if (registerSubscription != null) registerSubscription.cancel();
    return super.close();
  }
}
