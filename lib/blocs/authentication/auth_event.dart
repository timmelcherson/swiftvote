import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthCheckIfRegisteredEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final int age;
  final String gender;
  final String location;

  AuthRegisterEvent({
    required this.age,
    required this.gender,
    required this.location,
  });
}

class AuthSuccessEvent extends AuthEvent {
  final UserProfile userProfile;

  AuthSuccessEvent({required this.userProfile});
}

class AuthLogOutEvent extends AuthEvent {}
