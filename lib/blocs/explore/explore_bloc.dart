import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import './explore.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final VoteRepository voteRepository;
  final VoteBloc voteBloc;

  ExploreBloc({@required this.voteRepository, @required this.voteBloc})
      : super(
          ExploreCategoriesLoadedState(
            categories: CategoryExtension.categoryToString.values.toList(),
            categoryThumbnails: CategoryExtension.categoryThumbnails.values.toList(),
          ),
        );

  @override
  Stream<ExploreState> mapEventToState(
    ExploreEvent event,
  ) async* {
    if (event is ExploreCategoryTappedEvent) {
      yield* _mapExploreCategoryTappedEventToState(event);
    }
    if (event is ExploreCategoryReturnEvent) {
      yield* _mapExploreCategoryReturnEventToState(event);
    }
    if (event is ExploreCategorySelectedEvent) {
      yield* _mapExploreCategorySelectedEventToState(event);
    }
  }

  Stream<ExploreState> _mapExploreCategoryTappedEventToState(
      ExploreCategoryTappedEvent event) async* {
    try {
      List<Vote> votes = await voteRepository.getVotesByCategory(event.category);
      yield ExploreCategoryLoadedState(category: event.category, votes: votes);
    } catch (error) {
      yield ExploreCategoryLoadFailState();
    }
  }

  Stream<ExploreState> _mapExploreCategoryReturnEventToState(
      ExploreCategoryReturnEvent event) async* {
    yield ExploreCategoriesLoadedState(
      categories: CategoryExtension.categoryToString.values.toList(),
      categoryThumbnails: CategoryExtension.categoryThumbnails.values.toList(),
    );
  }
  
  Stream<ExploreState> _mapExploreCategorySelectedEventToState(
      ExploreCategorySelectedEvent event) async* {
    print('_mapExploreCategorySelectedEventToState');
    // yield VotesLoadedState(votes: null);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
