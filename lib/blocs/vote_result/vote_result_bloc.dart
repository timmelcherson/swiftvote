import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/vote_result/vote_result.dart';
import 'package:swiftvote/data/models/vote_result_model.dart';
import 'package:swiftvote/data/repositories.dart';

class VoteResultBloc extends Bloc<VoteResultEvent, VoteResultState> {
  final VoteRepository _voteRepository;
  StreamSubscription _voteSubscription;

  VoteResultBloc({@required VoteRepository voteRepository})
      : assert(voteRepository != null),
        _voteRepository = voteRepository,
        super(VoteResultInitialState());

  @override
  Stream<VoteResultState> mapEventToState(
    VoteResultEvent event,
  ) async* {
    if (event is VoteResultRequestedEvent) {
      yield* _mapVoteResultRequestedEventToState(event);
    }
  }

  Stream<VoteResultState> _mapVoteResultRequestedEventToState(
      VoteResultRequestedEvent event) async* {
    List<VoteResult> voteResults = await _voteRepository.getVoteResultsByVoteId(event.voteId);
    print('got vote results in voteResultBloc:');
    print(voteResults);
    if (voteResults != null && voteResults.length > 0) {
      int totalVotesForAllOptions =
          voteResults.fold(0, (prev, element) => prev + element.totalVotes);
      double firstOptionVoteShare = voteResults[0].totalVotes / totalVotesForAllOptions;
      double secondOptionVoteShare = voteResults[1].totalVotes / totalVotesForAllOptions;

      yield VoteResultLoadedState(
          voteResults: voteResults,
          firstOptionVoteShare: firstOptionVoteShare,
          secondOptionVoteShare: secondOptionVoteShare);
    } else {
      yield VoteResultLoadFailState();
    }
  }
}
