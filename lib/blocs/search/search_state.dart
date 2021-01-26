import 'package:meta/meta.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchCompletedState extends SearchState {}

class SearchFailedState extends SearchState {}
