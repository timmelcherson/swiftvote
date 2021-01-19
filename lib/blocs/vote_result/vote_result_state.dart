import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class VoteResultState extends Equatable {
  const VoteResultState();

  @override
  List<Object> get props => [];
}

@immutable
class VoteResultInitialState extends VoteResultState {}

@immutable
class VoteResultLoadedState extends VoteResultState {
  final List<VoteResult> voteResults;
  final double firstOptionVoteShare;
  final double secondOptionVoteShare;

  const VoteResultLoadedState(
      {this.voteResults, this.firstOptionVoteShare, this.secondOptionVoteShare});

  @override
  List<Object> get props => [];
}

@immutable
class VoteResultLoadFailState extends VoteResultState {}
