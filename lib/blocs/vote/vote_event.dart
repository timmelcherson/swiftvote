import 'package:meta/meta.dart';
import 'package:swiftvote/data/entities/index.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class VoteEvent {
  const VoteEvent();

  List<Object> get props => [];
}

// ---------------------------------- //
class LoadVotesEvent extends VoteEvent {}

// ---------------------------------- //
class AddVoteEvent extends VoteEvent {
  final VoteEntity voteEntity;

  // final String title;
  // final String author;
  // final String? sponsor;
  // final List<String> voteOptions;
  // final int totalVotes;
  // final List<String>? tags;
  // final List<String>? categories;

  const AddVoteEvent({required this.voteEntity});

  @override
  List<Object> get props => [this.voteEntity];

  @override
  String toString() => 'AddVoteEvent{voteEntity: $voteEntity}';
}

// ---------------------------------- //
class UpdateVoteEvent extends VoteEvent {
  final Vote updatedVote;

  const UpdateVoteEvent(this.updatedVote);

  @override
  List<Object> get props => [updatedVote];

  @override
  String toString() => 'UpdateVote { vote: $updatedVote }';
}

// ---------------------------------- //
class DeleteVoteEvent extends VoteEvent {
  final Vote vote;

  const DeleteVoteEvent(this.vote);

  @override
  List<Object> get props => [vote];

  @override
  String toString() => 'DeleteVote { vote: $vote }';
}

// ---------------------------------- //
class VotesUpdatedEvent extends VoteEvent {
  final List<Vote> votes;

  // final int newIndex;

  const VotesUpdatedEvent(this.votes);

  // const VotesUpdatedEvent(this.votes, [this.newIndex = 0]);

  @override
  List<Object> get props => [votes];
}

class IncreaseVoteScoreEvent extends VoteEvent {
  final Vote vote;
  final int optionIndex;

  IncreaseVoteScoreEvent(this.vote, this.optionIndex);
}

class PassVoteEvent extends VoteEvent {
  final List<Vote> votes;

  const PassVoteEvent(this.votes);
}

class ResetVotesEvent extends VoteEvent {
  final List<Vote> fullVoteList;

  const ResetVotesEvent(this.fullVoteList);
}
