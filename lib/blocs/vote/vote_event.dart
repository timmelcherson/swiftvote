import 'package:meta/meta.dart';

@immutable
abstract class VoteEvent {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

class VoteLoaded extends VoteEvent {}

class VoteAdded extends VoteEvent {}

class VoteUpdated extends VoteEvent {}

class VoteDeleted extends VoteEvent {}

