import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class ExploreEvent {
  const ExploreEvent();

  List<Object> get props => [];
}

class ExploreCategoriesLoadedEvent extends ExploreEvent {}

class ExploreCategoriesUpdatedEvent extends ExploreEvent {

  final List<Vote> votes;

  const ExploreCategoriesUpdatedEvent(this.votes);

  @override
  List<Object> get props => [votes];

  @override
  String toString() => 'ExploreCategoriesUpdatedEvent { votes: $votes }';
}

class ExploreCategoryTappedEvent extends ExploreEvent {
  final String category;

  ExploreCategoryTappedEvent({this.category});
}
