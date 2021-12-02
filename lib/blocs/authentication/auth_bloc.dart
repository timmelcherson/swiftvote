import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/data/repositories/index.dart';
import 'package:swiftvote/data/repositories/auth_repository.dart';
import 'package:swiftvote/responses/BaseResponse.dart';
import 'package:swiftvote/services/DeviceInfoService.dart';
import 'index.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserProfileRepository userProfileRepository;

  AuthBloc({
    required this.authRepository,
    required this.userProfileRepository,
  }) : super(AuthLoadingState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthCheckIfRegisteredEvent) {
      print('AuthCheckIfRegisteredEvent');
      yield* _mapAuthCheckIfRegisteredEventToState(event);
    } else if (event is AuthSuccessEvent) {
      print('AuthSuccessEvent');
      yield* _mapAuthSuccessEventToState(event);
    } else if (event is AuthRegisterEvent) {
      print('AuthRegisterEvent');
      yield* _mapAuthRegisterEventToState(event);
    }
    // else if (event is AuthLogOutEvent) {
    //   yield* _mapAuthLogOutEventToState();
    // }
  }

  Stream<AuthState> _mapAuthCheckIfRegisteredEventToState(
      AuthCheckIfRegisteredEvent event) async* {
    // var isSignedIn = await authRepository.isSignedIn();

    try {
      BaseResponse tokenResponse = await DeviceInfoService.getUniqueDeviceId();

      if (tokenResponse.success) {
        var userProfile = await userProfileRepository.fetchUserProfileById(
          id: tokenResponse.value,
        );
        print(
            'user with id: ${tokenResponse.value} exists: ${userProfile != null}');
        print(userProfile);
        if (userProfile != null) {
          // add(AuthSuccessEvent(userProfile: userProfile));
          print('yielding AuthSuccessState');
          yield AuthSuccessState(userProfile: userProfile);
        } else {
          print('yielding AuthNotRegisteredState');
          yield AuthNotRegisteredState();
        }
      }
    } catch (e) {
      print(e);
    }

    // print('USER SIGNED IN? $isSignedIn');
    //
    // if (isSignedIn) {
    //   // yield AuthSuccessState(user: (result['value'] as UserCredential).user);
    // } else {
    //   try {
    //     BaseResponse tokenResponse =
    //         await DeviceInfoService.getUniqueDeviceId();
    //
    //     if (tokenResponse.success) {
    //       add(AuthSignInEvent(deviceToken: tokenResponse.value));
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // yield AuthFailState(errorMessage: result['value'].toString());
  }

  Stream<AuthState> _mapAuthSuccessEventToState(AuthSuccessEvent event) async* {
    print('_mapAuthSignInEventToState token');
    print(event.userProfile);
    yield AuthSuccessState(userProfile: event.userProfile);
  }

  Stream<AuthState> _mapAuthRegisterEventToState(
      AuthRegisterEvent event) async* {
    try {
      BaseResponse tokenResponse = await DeviceInfoService.getUniqueDeviceId();
      print(tokenResponse);
      print('IN HERE');
      print(event);
      if (tokenResponse.success) {
        print('tokenResponse.success');
        UserProfile userProfile = UserProfile(
          userId: tokenResponse.value,
          age: event.age,
          gender: event.gender,
          location: event.location,
        );
        print(userProfile);
        BaseResponse createUserProfileResponse = await userProfileRepository
            .addNewUserProfile(userProfile: userProfile);

        if (createUserProfileResponse.success) {
          print('yielding AuthSuccessState');
          yield AuthSuccessState(userProfile: userProfile);
        } else {
          print('Failing here with message: ${createUserProfileResponse.value}');
          yield AuthFailState(errorMessage: createUserProfileResponse.errorMessage ?? '');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
