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
  StreamSubscription voteSubscription;

  ExploreBloc({@required this.voteRepository, @required this.voteBloc})
      : super(
          voteBloc.state is VotesLoadedState
              ? ExploreCategoriesLoadedState(
                  votes: (voteBloc.state as VotesLoadedState).fullVoteList,
                  categories: CategoryExtension.categoryToString.values.toList(),
                  categoryThumbnails: CategoryExtension.categoryThumbnails.values.toList())
              : ExploreCategoriesLoadingState(),
        ) {
    voteSubscription = voteBloc.listen((state) {
      if (state is VotesLoadedState) {
        add(ExploreCategoriesUpdatedEvent((voteBloc.state as VotesLoadedState).fullVoteList));
      }
    });
  }

  @override
  Stream<ExploreState> mapEventToState(
    ExploreEvent event,
  ) async* {
    if (event is ExploreCategoriesUpdatedEvent) {
      yield* _mapExploreCategoriesUpdatedEventToState(event);
    }
    if (event is ExploreCategoryTappedEvent) {
      yield* _mapExploreCategoryTappedEventToState(event);
    }
  }

  Stream<ExploreState> _mapExploreCategoriesUpdatedEventToState(
      ExploreCategoriesUpdatedEvent event) async* {
    try {
      final categories = CategoryExtension.categoryToString.values.toList();
      final categoryThumbnails = CategoryExtension.categoryThumbnails.values.toList();
      // final categoryImagePaths = CategoryExtension.categoryThumbnailAssetPath.values.toList();
      yield ExploreCategoriesLoadedState(
          votes: event.votes, categories: categories, categoryThumbnails: categoryThumbnails);
    } catch (_) {
      yield ExploreCategoriesLoadFailureState();
    }
  }

  Stream<ExploreState> _mapExploreCategoryTappedEventToState(ExploreCategoryTappedEvent event) async* {

    // event.category
    // get votes where category contains event.category from voteRepository
    try {
      List<Vote> votes = await voteRepository.getVotesByCategory(event.category);
      // print('finally in explore bloc, votes list length is: ${votes.length}');
    } catch (error) {
      print('Could not get votes for category ${event.category}, got error: $error');
      yield ExploreCategoryLoadFailState();
    }
  }

  @override
  Future<void> close() {
    voteSubscription.cancel();
    return super.close();
  }
}
