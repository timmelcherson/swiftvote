import 'package:flutter/material.dart';

@immutable
abstract class UserProfileEvent {

  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileLoadingEvent extends UserProfileEvent {}

class UserProfileLoadEvent extends UserProfileEvent {

  final String userId;

  const UserProfileLoadEvent({this.userId});
}

class UserProfileFailureEvent extends UserProfileEvent {}