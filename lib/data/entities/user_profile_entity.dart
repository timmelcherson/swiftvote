import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String userId;
  final String gender;
  final int age;
  final String location;
  final List<String> interests;
  final List<String> languages;

  const UserProfileEntity(
      this.userId, this.gender, this.age, this.location, this.interests, this.languages);

  @override
  List<Object> get props => [userId, gender, age, location, interests, languages];

  @override
  String toString() {
    return 'UserProfileEntity{userId: $userId, gender: $gender, age: $age, location: '
        '$location, interests: $interests, languages: $languages}';
  }

  Map<String, Object> toJson() {
    return {
      "userId": userId,
      "gender": gender,
      "age": age,
      "location": location,
      "interests": interests,
      "languages": languages,
    };
  }

  static UserProfileEntity fromJson(Map<String, Object> json) {
    List<String> _interests = new List<String>.from(json["interests"]);
    List<String> _languages = new List<String>.from(json["languages"]);

    UserProfileEntity userProfile = UserProfileEntity(
        json["userId"] as String,
        json["gender"] as String,
        json["age"] as int,
        json["location"] as String,
        _interests,
        _languages,
    );
    return userProfile;
  }

  static UserProfileEntity fromSnapshot(DocumentSnapshot snap) {
    List<String> _interests = new List<String>.from(snap.get('interests'));
    List<String> _languages = new List<String>.from(snap.get('languages'));

    return UserProfileEntity(
      snap.get('userId'),
      snap.get('gender'),
      snap.get('age'),
      snap.get('location'),
      _interests,
      _languages,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'gender': gender,
      'age': age,
      'location': location,
      'interests': interests,
      'languages': languages,
    };
  }
}
