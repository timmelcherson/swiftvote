import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(AuthenticationInitialState());

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
    final signedIn = await _userRepository.isSignedIn();

    print('AUTHENTICATION STARTED EVENT TO STATE');
    print(_userRepository);

    if (signedIn) {
      final user = await _userRepository.getUser();
      print('GOT USER: $user');
      yield AuthenticationSuccessState(user);
    } else {
      print('YIELDING FAIL STATE');
      yield AuthenticationFailState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogInEventToState() async* {
    yield AuthenticationSuccessState(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapAuthenticationLogOutEventToState() async* {
    yield AuthenticationFailState();
    _userRepository.signOut();
  }
}
