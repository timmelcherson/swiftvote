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
  final List<Vote> votes;
  final int randomIndex;

  const VotesLoadedState(this.votes, [this.randomIndex = 0]);

  @override
  List<Object> get props => [votes, randomIndex];

  @override
  String toString() => 'VotesLoaded{vote: $votes, index: $randomIndex}';
}

@immutable
class VotesLoadFailureState extends VoteState {}
