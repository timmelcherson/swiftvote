import 'dart:async';
import 'package:bloc/bloc.dart';
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
    final signedIn = await userRepository.isSignedIn();

    print('AUTHENTICATION STARTED EVENT TO STATE');
    print(userRepository);

    if (signedIn) {
      final user = await userRepository.getUser();
      // final userProfile = await userProfileRepository.getUserProfileById(user.uid);
      UserProfile userProfile;
      print('GOT USER: $user');
      yield AuthenticationSuccessState(user, userProfile);
    } else {
      print('YIELDING FAIL STATE');
      yield AuthenticationFailState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogInEventToState() async* {
    var user = await userRepository.getUser();
    UserProfile userProfile;
    bool hasProfile = userProfileRepository.hasProfile(user.uid);
    print('Log in user with ID: ${user.uid}');
    print('User had a userprofile already: $hasProfile');
    if (!hasProfile) {
      // final String userId;
      // final String gender;
      // final String dob;
      // final String location;
      // final List<String> interests;
      // final List<String> languages;
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
    yield AuthenticationSuccessState(user, userProfile);
  }

  Stream<AuthenticationState> _mapAuthenticationLogOutEventToState() async* {
    yield AuthenticationFailState();
    userRepository.signOut();
  }
}
