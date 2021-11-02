import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';

@immutable
abstract class UserProfileEvent {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

///
///
class UserProfilePrefetchEvent extends UserProfileEvent {}

class UserProfileCreateEvent extends UserProfileEvent {
  final String id;
  final String age;
  final String gender;
  final String location;

  const UserProfileCreateEvent({
    required this.id,
    required this.age,
    required this.gender,
    required this.location,
  });
}

class UserProfileFetchEvent extends UserProfileEvent {
  final String userId;

  const UserProfileFetchEvent(this.userId);
}

// class UserProfileUpdatedEvent extends UserProfileEvent {
//
//   final UserProfile user;
//   final bool updateDB;
//
//   const UserProfileUpdatedEvent(this.user, {this.updateDB = false});
// }

class UserProfileFailureEvent extends UserProfileEvent {}
