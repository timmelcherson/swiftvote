import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {


  @override
  List<Object> get props => [];
}

class RegisterSubmitEvent extends RegisterEvent {
  final int age;
  final String gender;
  final String location;


  RegisterSubmitEvent({this.age, this.gender, this.location});

  @override
  String toString() {
    return 'RegisterSignUpEvent{age: $age, gender: $gender, location: $location}';
  }


}
