import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreCategoriesLoadingState extends ExploreState {}

class ExploreCategoriesLoadedState extends ExploreState {
  final List<Vote> votes;
  final List<String> categories;
  // final List<String> categoryImagesPaths;
  final List<IconData> categoryThumbnails;

  const ExploreCategoriesLoadedState(
      {this.votes, this.categories, this.categoryThumbnails});

  @override
  List<Object> get props => [categories];

  @override
  String toString() {
    return 'ExploreCategoriesLoadSuccess{categories: $categories}';
  }
}

class ExploreCategoriesLoadFailureState extends ExploreState {}
