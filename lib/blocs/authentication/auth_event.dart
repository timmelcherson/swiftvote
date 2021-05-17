import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {

  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthStartedEvent extends AuthEvent {}

class AuthLogInEvent extends AuthEvent {

  final String email;
  final String password;

  AuthLogInEvent({@required this.email, @required this.password});
}

class AuthLogOutEvent extends AuthEvent {}