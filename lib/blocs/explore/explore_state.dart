import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreCategoriesLoadInProgress extends ExploreState {}

class ExploreCategoriesLoadSuccess extends ExploreState {
  final List<String> categories;
  final List<String> categoryImagesPaths;

  const ExploreCategoriesLoadSuccess(
      [this.categories = const [], this.categoryImagesPaths = const []]);

  @override
  List<Object> get props => [categories, categoryImagesPaths];

  @override
  String toString() {
    return 'ExploreCategoriesLoadSuccess{categories: $categories, categoryImagesPath: $categoryImagesPaths}';
  }
}

class ExploreCategoriesLoadFailure extends ExploreState {}
