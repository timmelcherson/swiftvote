import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';

@immutable
abstract class UserProfileEvent {

  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileLoadingEvent extends UserProfileEvent {}

class UserProfileUpdatedEvent extends UserProfileEvent {

  final UserProfile userProfile;

  const UserProfileUpdatedEvent(this.userProfile);
}

class UserProfileFailureEvent extends UserProfileEvent {}
