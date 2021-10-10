import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:swiftvote/blocs/navigation/index.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(MainNavBarState(index: 1));

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is MainNavBarTapEvent) {
      yield MainNavBarState(index: event.index);
    }
  }
}