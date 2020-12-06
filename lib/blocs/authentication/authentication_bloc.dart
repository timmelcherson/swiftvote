import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;

  AuthenticationBloc({@required this.userRepository, @required this.userProfileRepository})
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
    // final signedIn = await userRepository.isSignedIn();
    var user = await userRepository.getUser();
    print('GOT USER: $user');

    if (user != null) {
      final userProfile = await userProfileRepository.getUserProfileById(user.uid);

      print('GOT USER PROFILE: $userProfile');
      if (user != null && userProfile != null) {
        print('AUTHENTICATION STARTED EVENT TO STATE WAS SUCCESS');
        yield AuthenticationSuccessState(user, userProfile);
      }
    } else {
      print('YIELDING FAIL STATE');
      yield AuthenticationFailState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogInEventToState() async* {
    UserProfile userProfile;
    var user = await userRepository.getUser();

    bool hasProfile = userProfileRepository.hasProfile(user.uid);

    if (!hasProfile) {
      userProfile = UserProfile(
        userId: user.uid,
        gender: "",
        dob: "",
        location: "",
        interests: <String>[],
        languages: <String>[],
      );
      await userProfileRepository.addNewUserProfile(userProfile);
    }
    if (user != null && userProfile != null) {
      print('LOGIN EVENT TO STATE WAS SUCCESS');
      yield AuthenticationSuccessState(user, userProfile);
    } else {
      print('LOGIN EVENT TO STATE WAS FAIL');
      yield AuthenticationFailState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogOutEventToState() async* {
    yield AuthenticationFailState();
    userRepository.signOut();
  }
}
