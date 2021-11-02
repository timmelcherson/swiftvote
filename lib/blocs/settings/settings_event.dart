import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class SettingsEvent {
  const SettingsEvent();

  List<Object> get props => [];
}

// ---------------------------------- //
class LoadSettingsEvent extends SettingsEvent {

  final List<Vote> votes;
  final UserProfile userProfile;

  LoadSettingsEvent({required this.votes, required this.userProfile});
}


// ---------------------------------- //
class UpdateUserProfileEvent extends SettingsEvent {
  final UserProfile userProfile;

  const UpdateUserProfileEvent({required this.userProfile});

  @override
  List<Object> get props => [userProfile];

  @override
  String toString() => 'UpdateSettings { vote: $userProfile }';
}

