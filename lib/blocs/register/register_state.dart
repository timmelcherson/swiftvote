import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}
