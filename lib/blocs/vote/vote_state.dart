import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class VoteState extends Equatable{
  const VoteState();

  @override
  List<Object> get props => [];
}

class VotesLoading extends VoteState {}

class VotesLoaded extends VoteState {

  final List<Vote> votes;

  const VotesLoaded([this.votes = const []]);

  @override
  List<Object> get props => [votes];

  @override
  String toString() => 'VotesLoaded{vote: $votes}';
}

class VotesNotLoaded extends VoteState {}
