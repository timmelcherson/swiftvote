import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/utils/validators.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;

  LoginBloc({@required this.userRepository, @required this.userProfileRepository})
      : super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChange) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginWithCredentials) {
      yield* _mapLoginWithCredentialsToState(event.email, event.password);
    }
  }

  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentialsToState(String email, String password) async* {
    yield LoginState.loading();
    try {
      await userRepository.signInWithCredentials(email: email, password: password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
