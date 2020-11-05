import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/utils/validators.dart';

import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChangedEvent) {
      yield* _mapRegisterEmailChangedEventToState(event.email);
    } else if (event is RegisterPasswordChangedEvent) {
      yield* _mapRegisterPasswordChangedEventToState(event.password);
    } else if (event is RegisterConfirmPasswordChangedEvent) {
      yield* _mapRegisterConfirmPasswordChangedEventToState(event.password);
    } else if (event is RegisterSubmittedEvent) {
      yield* _mapRegisterSubmittedEventToState(email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedEventToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangedEventToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterConfirmPasswordChangedEventToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedEventToState({String email, String password}) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email: email, password: password);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
