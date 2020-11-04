import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChange extends LoginEvent {

  final String email;

  LoginEmailChange({this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChange extends LoginEvent {

  final String password;

  LoginPasswordChange({this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithCredentials extends LoginEvent {

  final String email;
  final String password;

  LoginWithCredentials({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}