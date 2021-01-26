import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent {}

class SearchSubmittedEvent extends SearchEvent {

  final String searchQuery;

  SearchSubmittedEvent({this.searchQuery});
}
