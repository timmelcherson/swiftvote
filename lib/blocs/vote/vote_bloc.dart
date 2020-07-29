import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:swiftvote/utils/test_db.dart';
import './vote.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {

  VoteBloc() : super(VoteLoadInProgress());



  @override
  Stream<VoteState> mapEventToState(
    VoteEvent event,
  ) async* {
    if (event is VoteLoaded) {
      yield* _mapVoteLoadedToState();
    } else if (event is VoteAdded) {
      yield* _mapVoteAddedToState(event);
    } else if (event is VoteUpdated) {
      yield* _mapVoteUpdatedToState(event);
    } else if (event is VoteDeleted) {
      yield* _mapVoteDeletedToState(event);
    }
  }

  Stream<VoteState> _mapVoteLoadedToState() async* {
    try {
      final votes = TestDb.voteList;
    } catch (_) {
      yield VoteLoadFailure();
    }
  }

  Stream<VoteState> _mapVoteAddedToState(VoteEvent event) async* {

  }

  Stream<VoteState> _mapVoteUpdatedToState(VoteEvent event) async* {

  }

  Stream<VoteState> _mapVoteDeletedToState(VoteEvent event) async* {

  }
}
