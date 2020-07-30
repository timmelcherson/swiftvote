import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/models/models.dart';

@immutable
abstract class VoteState extends Equatable{
  const VoteState();

  @override
  List<Object> get props => [];
}

class VotesLoadInProgress extends VoteState {}

class VotesLoadSuccess extends VoteState {

  final List<Vote> votes;

  const VotesLoadSuccess([this.votes = const []]);

  @override
  List<Object> get props => [votes];

  @override
  String toString() => 'VoteLoadSuccess{vote: $votes}';
}

class VoteLoadFailure extends VoteState {}
