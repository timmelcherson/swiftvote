import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';

@immutable
abstract class UserProfileEvent {

  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileLoadingEvent extends UserProfileEvent {}

class UserIdReceivedEvent extends UserProfileEvent {

  final String userId;

  const UserIdReceivedEvent(this.userId);
}

class UserProfileUpdatedEvent extends UserProfileEvent {

  final UserProfile userProfile;
  final bool updateDB;

  const UserProfileUpdatedEvent(this.userProfile, {this.updateDB = false});
}

// class UserProfilePersistEvent extends UserProfileEvent {}

class UserProfileFailureEvent extends UserProfileEvent {}
