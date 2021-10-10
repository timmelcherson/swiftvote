import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:swiftvote/data/repositories/index.dart';
import './index.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final VoteRepository voteRepository;

  SearchBloc({this.voteRepository}) : super(SearchInitialState());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchSubmittedEvent) {
      yield* _mapSearchSubmittedEventToState(event);
    }
  }

  Stream<SearchState> _mapSearchSubmittedEventToState(SearchSubmittedEvent event) async* {
    try {

      // await voteRepository.getVotesByTitle();

      yield SearchCompletedState();
    } catch (error) {
      print('Search fail in BLOC: $error');
      yield SearchFailedState();
    }
  }
}
