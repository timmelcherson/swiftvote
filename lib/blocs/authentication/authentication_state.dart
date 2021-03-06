import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models.dart';

@immutable
abstract class AuthenticationState extends Equatable {

  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {

  final User user;

  AuthenticationSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class  AuthenticationFailState extends AuthenticationState {}
