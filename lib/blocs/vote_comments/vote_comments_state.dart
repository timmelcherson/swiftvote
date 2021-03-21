import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/vote_comment_model.dart';
import 'package:swiftvote/data/models/vote_model.dart';

@immutable
abstract class VoteCommentsState extends Equatable {
  const VoteCommentsState();

  @override
  List<Object> get props => [];
}

@immutable
class VoteCommentsLoadingState extends VoteCommentsState {}

@immutable
class VoteCommentsLoadedState extends VoteCommentsState {
  final Vote vote;
  final List<VoteComment> comments;

  const VoteCommentsLoadedState({@required this.vote, @required this.comments});

  @override
  List<Object> get props => [comments];

  @override
  String toString() => 'VoteCommentsLoadedState{comments: comments}';

  List<VoteComment> get timeSortedComments =>
      comments..sort((current, next) => current.createdAt.compareTo(next.createdAt));
}

@immutable
class VoteCommentsLoadFailState extends VoteCommentsState {}
