import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'intro.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroLoadingState());

  @override
  Stream<IntroState> mapEventToState(
    IntroEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
