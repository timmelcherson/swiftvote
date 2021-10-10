import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class RegisterState extends Equatable {

  RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {

  final String userId;

  RegisterSuccessState({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class RegisterFailState extends RegisterState {

  final String errorMessage;

  RegisterFailState({this.errorMessage});
}