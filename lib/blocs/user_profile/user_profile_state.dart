import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileIdReceivedState extends UserProfileState {
  final String userProfileId;

  const UserProfileIdReceivedState(this.userProfileId);

  @override
  List<Object> get props => [userProfileId];

  @override
  String toString() {
    return 'UserProfileLoadedState{userProfileId: $userProfileId}';
  }
}

class UserProfileReadyState extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileReadyState({required this.userProfile});

  @override
  List<Object> get props => [userProfile];

  @override
  String toString() {
    return 'UserProfileLoadedState{userProfile: $userProfile}';
  }
}

class UserProfileCreateFailState extends UserProfileState {}

class UserProfileFetchFailState extends UserProfileState {}
