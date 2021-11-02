import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/data/models/vote_model.dart';

@immutable
abstract class VoteCommentsEvent {
  const VoteCommentsEvent();

  List<Object> get props => [];
}

class LoadVoteCommentsByVoteIdEvent extends VoteCommentsEvent {

  final Vote vote;

  LoadVoteCommentsByVoteIdEvent({required this.vote});
}

class VoteCommentsUpdatedEvent extends VoteCommentsEvent {
  final Vote vote;
  final List<VoteComment> comments;

  VoteCommentsUpdatedEvent({required this.vote, required this.comments});
}

class AddVoteCommentEvent extends VoteCommentsEvent {

  final String content;

  AddVoteCommentEvent({required this.content});
}