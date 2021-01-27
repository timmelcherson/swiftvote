import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class ExploreEvent {
  const ExploreEvent();

  List<Object> get props => [];
}

class ExploreCategoriesLoadedEvent extends ExploreEvent {}

class ExploreCategoryTappedEvent extends ExploreEvent {
  final String category;

  ExploreCategoryTappedEvent({this.category});
}

class ExploreCategorySelectedEvent extends ExploreEvent {
  final Vote vote;

  ExploreCategorySelectedEvent({this.vote});
}

class ExploreCategoryReturnEvent extends ExploreEvent {}
