import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/authentication/auth.dart';
import 'package:swiftvote/blocs/user_profile/user_profile.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/data/repositories.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final AuthBloc authBloc;
  final UserProfileRepository userProfileRepository;

  StreamSubscription authSubscription;

  UserProfileBloc({@required this.authBloc, @required this.userProfileRepository})
      : super(
          authBloc.state is AuthSuccessState
              ? UserIdReceivedState((authBloc.state as AuthSuccessState).user.uid)
              : UserProfileLoadingState(),
        ) {
    authSubscription = authBloc.stream.listen((state) {
      print('SETTING UP AUTH SUBSCRIPTION');
      if (state is AuthSuccessState) {
        print('USERPROFILEBLOC RECEIVED AuthSuccessState');
        add(UserIdReceivedEvent((authBloc.state as AuthSuccessState).user.uid));
      }
    });
  }

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is UserIdReceivedEvent) {
      yield* _mapUserIdReceivedEventToState(event);
    } else if (event is UserProfileUpdatedEvent) {
      yield* _mapUserProfileUpdatedEventToState(event);
    }
    // else if (event is UserProfilePersistEvent) {
    //   yield* _mapUserProfilePersistEventToState();
    // }
  }

  Stream<UserProfileState> _mapUserIdReceivedEventToState(UserIdReceivedEvent event) async* {
    UserProfile _userProfile = await userProfileRepository.getUserProfileById(event.userId);
    try {
      _userProfile ??= UserProfile(
        userId: event.userId,
        gender: "",
        age: null,
        location: "",
        interests: <String>[],
        languages: <String>[],
      );
      await userProfileRepository.addNewUserProfile(_userProfile);
      yield UserProfileReadyState(userProfile: _userProfile);
    } catch (_) {
      yield UserProfileLoadFailureState();
    }
  }

  Stream<UserProfileState> _mapUserProfileUpdatedEventToState(
      UserProfileUpdatedEvent event) async* {
    if (state is UserProfileReadyState) {
      try {
        if (event.updateDB) {
          userProfileRepository.updateUserProfile(event.userProfile);
        }
        yield UserProfileReadyState(userProfile: event.userProfile);
      } catch (_) {
        yield UserProfileLoadFailureState();
      }
    } else {
      yield UserProfileLoadFailureState();
    }
  }

  // Stream<UserProfileState> _mapUserProfilePersistEventToState() async* {
  //   if (state is UserProfileCreatedState) {
  //     try {
  //       userProfileRepository.updateUserProfile((state as UserProfileCreatedState).userProfile);
  //       yield UserProfileCreatedState(userProfile: (state as UserProfileCreatedState).userProfile);
  //     } catch (_) {
  //       print('Could not save user profile to database');
  //     }
  //   }
  // }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
