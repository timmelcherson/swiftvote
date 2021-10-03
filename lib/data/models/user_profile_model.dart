import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities/user_profile_entity.dart';

@immutable
class UserProfile {
  final String userId;
  final String gender;
  final String age;
  final String location;

  const UserProfile({this.userId, this.gender, this.age, this.location});

  UserProfile copyWith({
    String gender,
    String age,
    String location,
  }) {
    return UserProfile(
      userId: this.userId,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      location: location ?? this.location,
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(userId, gender, age, location);
  }

  static UserProfile fromEntity(UserProfileEntity entity) {
    return UserProfile(
      userId: entity.userId,
      gender: entity.gender,
      age: entity.age,
      location: entity.location,
    );
  }

  @override
  int get hashCode => userId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          gender == other.gender &&
          age == other.age &&
          location == other.location;

  @override
  String toString() {
    return 'UserProfile{userId: $userId, gender: $gender, age: $age, location: $location }';
  }
}
