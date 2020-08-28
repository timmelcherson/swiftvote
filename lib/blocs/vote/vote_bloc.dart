import 'dart:async';
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
        super(VotesLoading());

  @override
  Stream<VoteState> mapEventToState(
    VoteEvent event,
  ) async* {
    if (event is LoadVotes) {
      yield* _mapLoadVotesToState();
    } else if (event is AddVote) {
      yield* _mapAddVoteToState(event);
    } else if (event is UpdateVote) {
      yield* _mapUpdateVoteToState(event);
    } else if (event is DeleteVote) {
      yield* _mapDeleteVoteToState(event);
    }
  }

  Stream<VoteState> _mapLoadVotesToState() async* {
    _voteSubscription?.cancel();
    print("votesubscription");
    _voteSubscription = _voteRepository.votes().listen((votes) => add(VotesUpdated(votes)));
  }

  Stream<VoteState> _mapAddVoteToState(AddVote event) async* {
    _voteRepository.addNewVote(event.vote);
  }

  Stream<VoteState> _mapUpdateVoteToState(UpdateVote event) async* {
    _voteRepository.updateVote(event.updatedVote);
  }

  Stream<VoteState> _mapDeleteVoteToState(DeleteVote event) async* {
    _voteRepository.deleteVote(event.vote);
  }

  Stream<VoteState> _mapVotesUpdatedToState(VotesUpdated event) async* {
    yield VotesLoaded(event.votes);
  }

  @override
  Future<Function> close() {
    _voteSubscription?.cancel();
    return super.close();
  }
}
