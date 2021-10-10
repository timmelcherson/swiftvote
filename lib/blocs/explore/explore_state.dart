import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreCategoriesLoadingState extends ExploreState {}

class ExploreCategoriesLoadedState extends ExploreState {
  final List<String> categories;
  final List<IconData> categoryThumbnails;

  const ExploreCategoriesLoadedState({this.categories, this.categoryThumbnails});

  @override
  List<Object> get props => [categories];

  @override
  String toString() {
    return 'ExploreCategoriesLoadSuccess{categories: $categories}';
  }

  ExploreCategoriesLoadedState copyWith({
    List<String> categories,
    List<IconData> categoryThumbnails,
  }) {
    return ExploreCategoriesLoadedState(
      categories: categories ?? this.categories,
      categoryThumbnails: categoryThumbnails ?? this.categoryThumbnails,
    );
  }
}

class ExploreCategoriesLoadFailureState extends ExploreState {}

class ExploreCategoryLoadState extends ExploreState {
  final String category;

  ExploreCategoryLoadState({this.category});
}

class ExploreCategoryLoadedState extends ExploreState {
  final String category;
  final List<Vote> votes;

  ExploreCategoryLoadedState({this.category, this.votes});
}

class ExploreCategoryLoadFailState extends ExploreState {}
