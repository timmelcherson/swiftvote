import 'dart:async';
import 'package:bloc/bloc.dart';
import './search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  SearchBloc(SearchState initialState) : super(initialState);

  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
