import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities/user_profile_entitry.dart';

@immutable
class UserProfile {
  final String userId;
  final String gender;
  final int age;
  final String location;

  const UserProfile({
    required this.userId,
    required this.gender,
    required this.age,
    required this.location,
  });

  UserProfile copyWith({
    required String gender,
    required int age,
    required String location,
  }) {
    return UserProfile(
      userId: this.userId,
      gender: gender,
      age: age,
      location: location,
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
