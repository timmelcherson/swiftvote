import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class VoteState extends Equatable {
  const VoteState();

  @override
  List<Object> get props => [];
}

@immutable
class VotesLoadingState extends VoteState {}

@immutable
class VotesLoadedState extends VoteState {
  final List<Vote> fullVoteList;
  final List<Vote> votes;

  const VotesLoadedState({@required this.votes, this.fullVoteList});

  @override
  List<Object> get props => [votes];

  @override
  String toString() => 'VotesLoaded{vote: $votes}';
}

@immutable
class VotesLoadFailureState extends VoteState {}

@immutable
class VotesEmptyState extends VoteState {}

@immutable
class VotesResetState extends VoteState {}


