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
              ? UserProfileLoadedState(
                  (authenticationBloc.state as AuthenticationSuccessState).user.uid)
              : UserProfileLoadingState(),
        ) {
    authSubscription = authenticationBloc.listen((state) {
      print('LISTENER STARTING');
      print('STATE IS: $state');
      if (state is AuthenticationSuccessState) {
        print('LISTENER FIRED');
        add(UserProfileUpdatedEvent(
            (authenticationBloc.state as AuthenticationSuccessState).user.uid));
      }
    });
  }

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is UserProfileUpdatedEvent) {
      yield* _mapUserProfileUpdatedEventToState(event);
    }
  }

  Stream<UserProfileState> _mapUserProfileUpdatedEventToState(
      UserProfileUpdatedEvent event) async* {
    UserProfile _userProfile = await userProfileRepository.getUserProfileById(event.userId);
    print('_mapUserProfileUpdatedEventToState WITH ID: ${event.userId}');
    print('GOT USER PROFILE: $_userProfile');
    try {
      // UserProfileCreatedState
      if (_userProfile == null) {
        print('profile didnt exist, creating one for user with id: ${event.userId}');
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
      print('_mapUserProfileUpdatedEventToState YIELDING SUCCESS');
      yield UserProfileCreatedState(userProfile: _userProfile);
    } catch (_) {
      print('_mapUserProfileUpdatedEventToState YIELDING FAILURE');
      yield UserProfileLoadFailureState();
    }
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
