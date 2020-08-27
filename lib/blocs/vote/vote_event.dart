import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class VoteEvent {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

// ---------------------------------- //
class LoadVotes extends VoteEvent {}

// ---------------------------------- //
class AddVote extends VoteEvent {
  final Vote vote;

  const AddVote(this.vote);

  @override
  List<Object> get props => [vote];

  @override
  String toString() => 'AddVote { vote: $vote }';
}

// ---------------------------------- //
class UpdateVote extends VoteEvent {
  final Vote updatedVote;

  const UpdateVote(this.updatedVote);

  @override
  List<Object> get props => [updatedVote];

  @override
  String toString() => 'UpdateVote { vote: $updatedVote }';
}

// ---------------------------------- //
class DeleteVote extends VoteEvent {
  final Vote vote;

  const DeleteVote(this.vote);

  @override
  List<Object> get props => [vote];

  @override
  String toString() => 'DeleteVote { vote: $vote }';
}

// ---------------------------------- //
class VotesUpdated extends VoteEvent {
  final List<Vote> votes;

  const VotesUpdated(this.votes);

  @override
  List<Object> get props => [votes];
}
