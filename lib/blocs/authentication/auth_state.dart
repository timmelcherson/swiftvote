import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class AuthState extends Equatable {

  AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {}

class AuthNotRegisteredState extends AuthState {}

class AuthSuccessState extends AuthState {

  final UserProfile userProfile;

  AuthSuccessState({@required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

class AuthFailState extends AuthState {

  final String errorMessage;

  AuthFailState({this.errorMessage});
}
