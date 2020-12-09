import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/authentication/authentication.dart';
import 'package:swiftvote/blocs/user_profile/user_profile.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final AuthenticationBloc authenticationBloc;
  StreamSubscription authSubscription;

  UserProfileBloc({@required this.authenticationBloc})
      : super(
          authenticationBloc.state is AuthenticationSuccessState
              ? UserProfileLoadedState(
                  (authenticationBloc.state as AuthenticationSuccessState).userProfile)
              : UserProfileLoadingState(),
        ) {
    authSubscription = authenticationBloc.listen((state) {
      if (state is AuthenticationSuccessState) {
        add(UserProfileUpdatedEvent(
            (authenticationBloc.state as AuthenticationSuccessState).userProfile));
      }
    });
  }
  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is UserProfileUpdatedEvent) {
      yield* _mapUserProfileUpdatedEventToState();
    }
  }

  Stream<UserProfileState> _mapUserProfileUpdatedEventToState(UserProfileUpdatedEvent event) async* {
    try {
      yield UserProfileLoadedState(event.userProfile);
    } catch (_) {
      yield UserProfileLoadFailureState();
    }
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
