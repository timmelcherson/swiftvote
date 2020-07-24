import 'dart:async';
import 'package:bloc/bloc.dart';
import './vote.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {

  VoteBloc() : super(null);

  @override
  VoteState get initialState => InitialVoteState();

  @override
  Stream<VoteState> mapEventToState(
    VoteEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
