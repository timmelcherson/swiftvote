import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {

  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {

  final User _user;

  AuthenticationSuccessState(this._user);

  @override
  List<Object> get props => [_user];
}

class  AuthenticationFailState extends AuthenticationState {}
