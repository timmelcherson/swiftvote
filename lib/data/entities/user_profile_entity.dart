import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String userId;
  final String gender;
  final String age;
  final String location;

  const UserProfileEntity(this.userId, this.gender, this.age, this.location);

  @override
  List<Object> get props => [userId, gender, age, location];

  @override
  String toString() {
    return 'UserProfileEntity{userId: $userId, gender: $gender, age: $age, location: '
        '$location }';
  }

  Map<String, Object> toJson() {
    return {
      "userId": userId,
      "gender": gender,
      "age": age,
      "location": location,
    };
  }

  static UserProfileEntity fromJson(Map<String, Object> json) {
    UserProfileEntity userProfile = UserProfileEntity(
        json["userId"] as String,
        json["gender"] as String,
        json["age"] as String,
        json["location"] as String);
    return userProfile;
  }

  static UserProfileEntity fromSnapshot(DocumentSnapshot snap) {
    return UserProfileEntity(snap.get('userId'), snap.get('gender'),
        snap.get('age'), snap.get('location'));
  }

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'gender': gender,
      'age': age,
      'location': location
    };
  }
}
