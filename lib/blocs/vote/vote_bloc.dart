import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import './vote.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final VoteRepository _voteRepository;
  StreamSubscription _voteSubscription;

  VoteBloc({@required VoteRepository voteRepository})
      : assert(voteRepository != null),
        _voteRepository = voteRepository,
        super(VotesLoadingState());

  @override
  Stream<VoteState> mapEventToState(
    VoteEvent event,
  ) async* {
    if (event is LoadVotesEvent) {
      yield* _mapLoadVotesToState();
    } else if (event is AddVoteEvent) {
      yield* _mapAddVoteToState(event);
    } else if (event is UpdateVoteEvent) {
      yield* _mapUpdateVoteToState(event);
    } else if (event is DeleteVoteEvent) {
      yield* _mapDeleteVoteToState(event);
    } else if (event is VotesUpdatedEvent) {
      yield* _mapVotesUpdatedToState(event);
    } else if (event is PassVoteEvent) {
      _mapPassVoteToState(event);
    }
  }

  Stream<VoteState> _mapLoadVotesToState() async* {
    _voteSubscription?.cancel();
    print("votesubscription");
    _voteSubscription = _voteRepository.getVotes().listen((votes) => add(VotesUpdatedEvent(votes)));
  }

  Stream<VoteState> _mapAddVoteToState(AddVoteEvent event) async* {
    _voteRepository.addNewVote(event.vote);
  }

  Stream<VoteState> _mapUpdateVoteToState(UpdateVoteEvent event) async* {
    _voteRepository.updateVote(event.updatedVote);
  }

  Stream<VoteState> _mapDeleteVoteToState(DeleteVoteEvent event) async* {
    _voteRepository.deleteVote(event.vote);
  }

  Stream<VoteState> _mapVotesUpdatedToState(VotesUpdatedEvent event) async* {
    int _randomIndex;

    do {
      _randomIndex = Random().nextInt(event.votes.length);
    } while (_randomIndex == event.newIndex);

    yield VotesLoadedState(event.votes, _randomIndex);
  }

  _mapPassVoteToState(PassVoteEvent event) =>
      VotesLoadedState(event.votes, Random().nextInt(event.votes.length));

  @override
  Future<Function> close() {
    _voteSubscription?.cancel();
    return super.close();
  }
}
