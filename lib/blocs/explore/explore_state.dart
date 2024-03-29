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

  const ExploreCategoriesLoadedState({
    required this.categories,
    required this.categoryThumbnails,
  });

  @override
  List<Object> get props => [categories];

  @override
  String toString() {
    return 'ExploreCategoriesLoadSuccess{categories: $categories}';
  }

  ExploreCategoriesLoadedState copyWith({
    required List<String> categories,
    required List<IconData> categoryThumbnails,
  }) {
    return ExploreCategoriesLoadedState(
      categories: categories,
      categoryThumbnails: categoryThumbnails,
    );
  }
}

class ExploreCategoriesLoadFailureState extends ExploreState {}

class ExploreCategoryLoadState extends ExploreState {
  final String category;

  ExploreCategoryLoadState({required this.category});
}

class ExploreCategoryLoadedState extends ExploreState {
  final String category;
  final List<Vote> votes;

  ExploreCategoryLoadedState({required this.category, required this.votes});
}

class ExploreCategoryLoadFailState extends ExploreState {}
