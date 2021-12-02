import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/blocs/vote_result/index.dart';
import 'package:swiftvote/data/models/vote_result_model.dart';
import 'package:swiftvote/data/repositories/index.dart';

class VoteResultBloc extends Bloc<VoteResultEvent, VoteResultState> {
  final VoteRepository voteRepository;
  final UserProfileBloc userProfileBloc;

  VoteResultBloc({required this.voteRepository, required this.userProfileBloc})
      : super(VoteResultInitialState());

  @override
  Stream<VoteResultState> mapEventToState(
    VoteResultEvent event,
  ) async* {
    if (event is LoadVoteResultByVoteIdEvent) {
      yield* _mapLoadVoteResultByVoteIdEventToState(event);
    }
    // if (event is VoteResultUpdatedEvent) {
    //   yield* _mapVoteResultUpdatedEventToState(event);
    // }
    if (event is VoteResultVotedEvent) {
      yield* _mapVoteResultVotedEventToState(event);
    }
  }

  Stream<VoteResultState> _mapLoadVoteResultByVoteIdEventToState(
    LoadVoteResultByVoteIdEvent event,
  ) async* {
    print(
        '_mapLoadVoteResultByVoteIdEventToState for voteId: ${event.vote.id}');
  }

  // Stream<VoteResultState> _mapVoteResultUpdatedEventToState(
  //   VoteResultUpdatedEvent event,
  // ) async* {
  //   yield VoteResultLoadedState(vote: event.vote, voteResults: event.results);
  // }

  Stream<VoteResultState> _mapVoteResultVotedEventToState(
      VoteResultVotedEvent event) async* {
    yield VoteResultReadyState(vote: event.vote);
    // print('_mapAddVoteResultEventToState');
    // VoteResult result = VoteResult(
    //   voterId: event.voter.userId,
    //   voterAge: event.voter.age,
    //   voterGender: event.voter.gender,
    //   votedOptionIndex: event.votedIndex,
    // );
    // print(result);
    // try {
    //   voteRepository.addVoteResult(
    //     voteId: event.voteId,
    //     userId: event.voter.userId,
    //     result: result,
    //   );
    // } catch (error) {
    //   print('Error in _mapAddVoteResultEventToState: $error');
    // }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
