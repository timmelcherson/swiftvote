import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class VoteResultEvent {
  const VoteResultEvent();

  List<Object> get props => [];
}

class LoadVoteResultByVoteIdEvent extends VoteResultEvent {
  final Vote vote;

  LoadVoteResultByVoteIdEvent({required this.vote});
}

class VoteResultUpdatedEvent extends VoteResultEvent {
  final Vote vote;
  final List<VoteResult> results;

  VoteResultUpdatedEvent({required this.vote, required this.results});
}

class VoteResultVotedEvent extends VoteResultEvent {
  final Vote vote;

  const VoteResultVotedEvent({
    required this.vote,
  });

  @override
  List<Object> get props => [vote];
}
