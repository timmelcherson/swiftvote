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
    } else if (event is IncreaseVoteScoreEvent) {
      _mapIncreaseVoteScoreToState(event);
    } else if (event is PassVoteEvent) {
      yield* _mapVotePassedToState(event);
    } else if (event is ResetVotesEvent) {
      yield* _mapResetVotesToState(event);
    }
  }

  Stream<VoteState> _mapLoadVotesToState() async* {
    _voteSubscription?.cancel();
    print("votesubscription");
    _voteSubscription = _voteRepository.getVotes().listen((votes) => add(VotesUpdatedEvent(votes)));
  }

  Stream<VoteState> _mapAddVoteToState(AddVoteEvent event) async* {
    print("votesubscription");
    _voteRepository.addNewVote(event.vote);
  }

  Stream<VoteState> _mapUpdateVoteToState(UpdateVoteEvent event) async* {
    _voteRepository.updateVote(event.updatedVote);
  }

  Stream<VoteState> _mapDeleteVoteToState(DeleteVoteEvent event) async* {
    _voteRepository.deleteVote(event.vote);
  }

  Stream<VoteState> _mapVotesUpdatedToState(VotesUpdatedEvent event) async* {

    List<Vote> newList = List.from(event.votes);
    newList.shuffle();
    print('-------------------------------------');
    newList.forEach((element) => print(element.title));
    print('-------------------------------------');
    yield VotesLoadedState(votes: newList, fullVoteList: event.votes);
    // print('%%%%%%%%%%%%%%');
    // print('event.newIndex: ${event.newIndex}');
    // print('%%%%%%%%%%%%%%');
    // event.votes.removeAt(index)
    // var freeIndexList = Iterable.generate(event.votes.length).toList();
    // freeIndexList.removeAt(event.newIndex);
    // int _randomIndex = Random().nextInt(freeIndexList.length);
  }

  Stream<VoteState> _mapVotePassedToState(PassVoteEvent event) async* {

    List<Vote> newList = event.votes;
    newList.removeAt(0);
    newList.shuffle();
    yield VotesLoadedState(votes: newList);

    // if (newList.length == 0 && newList.isEmpty) {
    //   yield VotesEmptyState();
    // }
    // else {
    //   newList.shuffle();
    //   yield VotesLoadedState(votes: newList);
    // }
  }

  Stream<VoteState> _mapResetVotesToState(ResetVotesEvent event) async* {
    print('YIELDING RESET STATE');
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    event.fullVoteList.forEach((element) => print(element.title));
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    yield VotesLoadedState(votes: event.fullVoteList, fullVoteList: event.fullVoteList);
  }

  _mapIncreaseVoteScoreToState(IncreaseVoteScoreEvent event) {
    event.vote.votes[event.optionIndex] += 1;
    _voteRepository.updateVote(event.vote);
  }

  @override
  Future<void> close() {
    _voteSubscription?.cancel();
    return super.close();
  }
}
