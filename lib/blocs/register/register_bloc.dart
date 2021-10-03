import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/repositories/user_profile_repository.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/utils/validators.dart';

import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserProfileRepository userProfileRepository;

  RegisterBloc({@required this.userProfileRepository})
      : super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChangedEvent) {
      yield* _mapRegisterEmailChangedEventToState(event.email);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedEventToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterSubmittedEventToState({String email, String password}) async* {
    yield RegisterState.loading();
    try {
      // await userRepository.signUp(email: email, password: password);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
