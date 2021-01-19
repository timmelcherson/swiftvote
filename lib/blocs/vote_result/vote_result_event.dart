import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class VoteResultEvent {
  const VoteResultEvent();

  List<Object> get props => [];
}

class VoteResultRequestedEvent extends VoteResultEvent {

  final String voteId;

  const VoteResultRequestedEvent({this.voteId});

  @override
  List<Object> get props => [voteId];
}
