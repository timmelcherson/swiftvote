import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/blocs/vote_result/index.dart';
import 'package:swiftvote/data/models/vote_result_model.dart';
import 'package:swiftvote/data/repositories/index.dart';

class VoteResultBloc extends Bloc<VoteResultEvent, VoteResultState> {
  final VoteRepository voteRepository;
  final UserProfileBloc userProfileBloc;
  StreamSubscription _voteSubscription;

  VoteResultBloc({@required this.voteRepository, this.userProfileBloc})
      : assert(voteRepository != null),
        super(VoteResultInitialState());

  @override
  Stream<VoteResultState> mapEventToState(
    VoteResultEvent event,
  ) async* {
    print('GOT EVENT: $event');
    if (event is LoadVoteResultByVoteIdEvent) {
      yield* _mapLoadVoteResultByVoteIdEventToState(event);
    }
    if (event is VoteResultUpdatedEvent) {
      yield* _mapVoteResultUpdatedEventToState(event);
    }
    if (event is AddVoteResultEvent) {
      yield* _mapAddVoteResultEventToState(event);
    }
  }

  Stream<VoteResultState> _mapLoadVoteResultByVoteIdEventToState(
    LoadVoteResultByVoteIdEvent event,
  ) async* {
    _voteSubscription?.cancel();
    print('_mapLoadVoteResultByVoteIdEventToState for voteId: ${event.vote.id}');
    _voteSubscription = voteRepository.getVoteResultByVoteId(voteId: event.vote.id).listen(
          (results) => add(
            VoteResultUpdatedEvent(vote: event.vote, results: results),
          ),
        );
  }

  Stream<VoteResultState> _mapVoteResultUpdatedEventToState(
    VoteResultUpdatedEvent event,
  ) async* {
    yield VoteResultLoadedState(vote: event.vote, voteResults: event.results);
  }

  Stream<VoteResultState> _mapAddVoteResultEventToState(AddVoteResultEvent event) async* {
    print('_mapAddVoteResultEventToState');
    VoteResult result = VoteResult(
      voterId: event.voter.userId,
      voterAge: event.voter.age,
      voterGender: event.voter.gender,
      votedOptionIndex: event.votedIndex,
    );
    print(result);
    try {
      voteRepository.addVoteResult(
        voteId: event.voteId,
        userId: event.voter.userId,
        result: result,
      );
    } catch (error) {
      print('Error in _mapAddVoteResultEventToState: $error');
    }
  }
}
