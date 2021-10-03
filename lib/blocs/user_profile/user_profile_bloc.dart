import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/user_profile/user_profile.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/data/repositories.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository;

  UserProfileBloc({@required this.userProfileRepository})
      : super(UserProfileLoadingState());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is UserProfileCreateEvent) {
      yield* _mapUserProfileCreateEventToState(event);
    } else if (event is UserProfileFetchEvent) {
      yield* _mapUserProfileFetchEventToState(event);
    }
    // else if (event is UserProfilePersistEvent) {
    //   yield* _mapUserProfilePersistEventToState();
    // }
  }

  Stream<UserProfileState> _mapUserProfileCreateEventToState(
      UserProfileCreateEvent event) async* {
    try {
      String userId = await userProfileRepository.addNewUserProfile(
        age: event.age,
        gender: event.gender,
        location: event.location,
      );

      yield UserProfileReadyState(
        userProfile: UserProfile(
          userId: userId,
          age: event.age,
          gender: event.gender,
          location: event.location,
        ),
      );
    } catch (_) {
      yield UserProfileCreateFailState();
    }
  }

  Stream<UserProfileState> _mapUserProfileFetchEventToState(
      UserProfileFetchEvent event) async* {
    try {
      UserProfile _userProfile =
          await userProfileRepository.fetchUserProfileById(id: event.userId);

      yield UserProfileReadyState(userProfile: _userProfile);
    } catch (_) {
      yield UserProfileFetchFailState();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
