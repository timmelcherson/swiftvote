import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/models/models.dart';
import 'package:swiftvote/repositories/vote_repository.dart';
import './vote.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {

  final VoteRepository voteRepository;
  VoteBloc({@required this.voteRepository}) : super(VotesLoadInProgress());



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

  void testPrint(List<Vote> votes) {

  }

  Stream<VoteState> _mapVoteLoadedToState() async* {
    print(voteRepository);
    try {
      final votes = await this.voteRepository.loadVotes();
      yield VotesLoadSuccess(votes);
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
