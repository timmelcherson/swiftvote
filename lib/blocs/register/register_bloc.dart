import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/data/repositories/user_profile_repository.dart';
import 'package:swiftvote/data/repositories/auth_repository.dart';
import 'package:swiftvote/responses/BaseResponse.dart';
import 'package:swiftvote/services/DeviceInfoService.dart';
import 'package:swiftvote/utils/validators.dart';

import 'index.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final UserProfileRepository userProfileRepository;

  RegisterBloc(
      {@required this.userProfileRepository, @required this.authRepository})
      : super(RegisterInitialState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterSubmitEvent) {
      yield* _mapRegisterSubmitEventToState(event);
    }
  }

  // Stream<RegisterState> _mapRegisterEmailChangedEventToState(String email) async* {
  //   yield state.update(isEmailValid: Validators.isValidEmail(email));
  // }

  // Stream<RegisterState> _mapRegisterSubmittedEventToState({String email, String password}) async* {
  //   yield RegisterState.loading();
  //   try {
  //     // await authRepository.signUp(email: email, password: password);
  //     yield RegisterState.success();
  //   } catch (error) {
  //     print(error);
  //     yield RegisterState.failure();
  //   }
  // }

  Stream<RegisterState> _mapRegisterSubmitEventToState(
      RegisterSubmitEvent event) async* {
    yield RegisterLoadingState();
    try {
      BaseResponse idResponse = await DeviceInfoService.getUniqueDeviceId();
      if (idResponse.success) {
        BaseResponse signInResponse =
            await authRepository.signInWithCustomToken(token: idResponse.value);

        if (signInResponse.success) {

          // Create user profile
          UserProfile userProfile = UserProfile(
            userId: signInResponse.value,
            age: event.age,
            gender: event.gender,
            location: event.location
          );
          // yield RegisterSuccessState(userProfile: userProfile)
        } else {
          yield RegisterFailState(errorMessage: "Failed to sign in to firebase");
        }
      }
    } catch (error) {
      print(error);
      yield RegisterFailState(errorMessage: error.toString());
    }
  }
}
