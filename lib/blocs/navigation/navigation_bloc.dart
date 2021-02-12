import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:swiftvote/blocs/navigation/navigation.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(MainNavBarState(index: 2));

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is MainNavBarTapEvent) {
      yield MainNavBarState(index: event.index);
    }
  }
}