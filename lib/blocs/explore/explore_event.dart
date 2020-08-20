import 'package:meta/meta.dart';

@immutable
abstract class ExploreEvent {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class ExploreLoaded extends ExploreEvent {}

class ExploreCategorySelected extends ExploreEvent {}

class AllExploreCategoriesSelected extends ExploreEvent {}