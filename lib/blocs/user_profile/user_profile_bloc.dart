import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/authentication/authentication.dart';
import 'package:swiftvote/blocs/user_profile/user_profile.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/data/repositories.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final AuthenticationBloc authenticationBloc;
  final UserProfileRepository userProfileRepository;

  StreamSubscription authSubscription;

  UserProfileBloc({@required this.authenticationBloc, @required this.userProfileRepository})
      : super(
          authenticationBloc.state is AuthenticationSuccessState
              ? UserIdReceivedState(
                  (authenticationBloc.state as AuthenticationSuccessState).user.uid)
              : UserProfileLoadingState(),
        ) {
    authSubscription = authenticationBloc.stream.listen((state) {
      if (state is AuthenticationSuccessState) {
        add(UserIdReceivedEvent((authenticationBloc.state as AuthenticationSuccessState).user.uid));
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
      // UserProfileCreatedState
      if (_userProfile == null) {
        _userProfile = UserProfile(
          userId: event.userId,
          gender: "",
          dob: "",
          location: "",
          interests: <String>[],
          languages: <String>[],
        );
        await userProfileRepository.addNewUserProfile(_userProfile);
      }
      yield UserProfileCreatedState(userProfile: _userProfile);
    } catch (_) {
      yield UserProfileLoadFailureState();
    }
  }

  Stream<UserProfileState> _mapUserProfileUpdatedEventToState(
      UserProfileUpdatedEvent event) async* {
    if (state is UserProfileCreatedState) {
      try {
        if (event.updateDB) {
          userProfileRepository.updateUserProfile(event.userProfile);
        }
        yield UserProfileCreatedState(userProfile: event.userProfile);
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
