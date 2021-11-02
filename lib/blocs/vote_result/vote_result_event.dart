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

class AddVoteResultEvent extends VoteResultEvent {
  final String voteId;
  final int votedIndex;
  final UserProfile voter;

  const AddVoteResultEvent({
    required this.voteId,
    required this.votedIndex,
    required this.voter,
  });

  @override
  List<Object> get props => [voteId];
}
