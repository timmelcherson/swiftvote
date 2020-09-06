import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:swiftvote/data/models.dart';
import './explore.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {

  ExploreBloc() : super(ExploreCategoriesLoadInProgress());

  @override
  Stream<ExploreState> mapEventToState(
    ExploreEvent event,
  ) async* {
    if (event is ExploreLoaded) {
      yield* _mapExploreLoadedToState();
    } else if (event is ExploreCategorySelected) {
      yield* _mapExploreCategorySelectedToState(event);
    } else if (event is AllExploreCategoriesSelected) {
      yield* _mapAllExploreCategoriesSelectedToState(event);
    }
  }

  Stream<ExploreState> _mapExploreLoadedToState() async* {
    try {
      final categories = CategoryExtension.categoryToString.values.toList();
      final categoryImagePaths = CategoryExtension.categoryThumbnailAssetPath.values.toList();
      yield ExploreCategoriesLoadSuccess(categories, categoryImagePaths);
    } catch(_) {
      yield ExploreCategoriesLoadFailure();
    }
  }

  Stream<ExploreState> _mapExploreCategorySelectedToState(ExploreEvent event) {

  }

  Stream<ExploreState> _mapAllExploreCategoriesSelectedToState(ExploreEvent event) {

  }
}
