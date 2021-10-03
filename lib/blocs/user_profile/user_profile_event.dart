import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';

@immutable
abstract class UserProfileEvent {

  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileLoadingEvent extends UserProfileEvent {}

class UserProfileCreateEvent extends UserProfileEvent {
  final String age;
  final String gender;
  final String location;

  const UserProfileCreateEvent({this.age, this.gender, this.location});
}

class UserProfileFetchEvent extends UserProfileEvent {

  final String userId;

  const UserProfileFetchEvent(this.userId);
}

class UserProfileUpdatedEvent extends UserProfileEvent {

  final UserProfile userProfile;
  final bool updateDB;

  const UserProfileUpdatedEvent(this.userProfile, {this.updateDB = false});
}

class UserProfileFailureEvent extends UserProfileEvent {}
