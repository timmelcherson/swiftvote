import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : super(AuthenticationInitialState());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStartedEvent) {
      yield* _mapAuthenticationStartedEventToState();
    } else if (event is AuthenticationLogInEvent) {
      yield* _mapAuthenticationLogInEventToState();
    } else if (event is AuthenticationLogOutEvent) {
      yield* _mapAuthenticationLogOutEventToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedEventToState() async* {
    var user = await userRepository.getUser();

    if (user != null) {
      yield AuthenticationSuccessState(user);
    } else {
      yield AuthenticationFailState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogInEventToState() async* {

    var user = await userRepository.getUser();

    if (user != null) {
      yield AuthenticationSuccessState(user);
    } else {
      yield AuthenticationFailState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogOutEventToState() async* {
    yield AuthenticationFailState();
    userRepository.signOut();
  }
}
