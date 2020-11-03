import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {

  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationStartedEvent extends AuthenticationEvent {}

class AuthenticationLogInEvent extends AuthenticationEvent {}

class AuthenticationLogOutEvent extends AuthenticationEvent {}