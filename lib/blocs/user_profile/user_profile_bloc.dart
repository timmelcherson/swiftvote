import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/user_profile/index.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/data/repositories/index.dart';
import 'package:swiftvote/responses/BaseResponse.dart';
import 'package:swiftvote/services/DeviceInfoService.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository;

  UserProfileBloc({@required this.userProfileRepository})
      : super(UserProfileLoadingState());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is UserProfilePrefetchEvent) {
      yield* _mapUserProfilePrefetchEventToState(event);
    }
    // else if (event is UserProfileFetchEvent) {
    //   yield* _mapUserProfileFetchEventToState(event);
    // }
    // else if (event is UserProfilePersistEvent) {
    //   yield* _mapUserProfilePersistEventToState();
    // }
  }


  Stream<UserProfileState> _mapUserProfilePrefetchEventToState(
      UserProfilePrefetchEvent event) async* {
    try {
      BaseResponse deviceResponse = await DeviceInfoService.getUniqueDeviceId();

      if (deviceResponse.success) {
        UserProfile _userProfile =
        await userProfileRepository.fetchUserProfileById(id: deviceResponse.value);

        if (_userProfile != null) {
          yield UserProfileReadyState(userProfile: _userProfile);
        } else {
          yield UserProfileFetchFailState();
        }
      } else {
        yield UserProfileFetchFailState();
      }
    } catch (e) {
      yield UserProfileFetchFailState();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
