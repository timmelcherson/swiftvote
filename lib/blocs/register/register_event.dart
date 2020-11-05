import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {


  @override
  List<Object> get props => [];
}

class RegisterEmailChangedEvent extends RegisterEvent {
  final String email;

  RegisterEmailChangedEvent({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChangedEvent extends RegisterEvent {
  final String password;

  RegisterPasswordChangedEvent({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterConfirmPasswordChangedEvent extends RegisterEvent {
  final String password;

  RegisterConfirmPasswordChangedEvent({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterSubmittedEvent extends RegisterEvent {
  final String email;
  final String password;

  RegisterSubmittedEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
