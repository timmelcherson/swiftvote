import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
