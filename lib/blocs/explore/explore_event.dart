import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class ExploreEvent {
  const ExploreEvent();

  List<Object> get props => [];
}

class ExploreCategoriesLoadedEvent extends ExploreEvent {}

class ExploreCategoryTappedEvent extends ExploreEvent {
  final String category;

  ExploreCategoryTappedEvent({required this.category});
}

class ExploreCategorySelectedEvent extends ExploreEvent {
  final Vote vote;

  ExploreCategorySelectedEvent({required this.vote});
}

class ExploreCategoryReturnEvent extends ExploreEvent {}
