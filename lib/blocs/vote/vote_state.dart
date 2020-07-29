import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/models/models.dart';

@immutable
abstract class VoteState extends Equatable{
  const VoteState();

  @override
  List<Object> get props => [];
}

class VoteLoadInProgress extends VoteState {}

class VoteLoadSuccess extends VoteState {

  final Vote vote;

  const VoteLoadSuccess(this.vote);

  @override
  List<Object> get props => [vote];

  @override
  String toString() => 'VoteLoadSuccess{vote: $vote}';
}

class VoteLoadFailure extends VoteState {}
