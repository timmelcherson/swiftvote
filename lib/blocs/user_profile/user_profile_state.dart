import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileLoadingState extends UserProfileState {}

class UserIdReceivedState extends UserProfileState {
  final String userId;

  const UserIdReceivedState(this.userId);

  @override
  List<Object> get props => [userId];

  @override
  String toString() {
    return 'UserProfileLoadedState{userId: $userId}';
  }
}

class UserProfileCreatedState extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileCreatedState({this.userProfile});

  @override
  List<Object> get props => [userProfile];

  @override
  String toString() {
    return 'UserProfileLoadedState{userProfile: $userProfile}';
  }
}

class UserProfileLoadFailureState extends UserProfileState {}
