import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

@immutable
class SettingsLoadingState extends SettingsState {}

@immutable
class SettingsReadyState extends SettingsState {
  final UserProfile userProfile;
  final List<Vote> votes;

  const SettingsReadyState({required this.votes, required this.userProfile});

  @override
  List<Object> get props => [votes, userProfile];

  @override
  String toString() => 'SettingsLoaded{vote: $votes, userProfile: $userProfile}';
}

@immutable
class SettingsLoadFailureState extends SettingsState {}



