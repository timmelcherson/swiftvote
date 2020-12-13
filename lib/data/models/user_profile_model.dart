import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities/user_profile_entity.dart';

@immutable
class UserProfile {
  final String userId;
  final String gender;
  final String dob;
  final String location;
  final List<String> interests;
  final List<String> languages;

  const UserProfile(
      {this.userId, this.gender, this.dob, this.location, this.interests, this.languages});

  UserProfile copyWith(
      {String gender,
      String dob,
      String location,
      List<String> interests,
      List<String> languages}) {
    return UserProfile(
        userId: this.userId,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        location: location ?? this.location,
        interests: interests ?? this.interests,
        languages: languages ?? this.languages);
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(userId, gender, dob, location, interests, languages);
  }

  static UserProfile fromEntity(UserProfileEntity entity) {
    return UserProfile(
        userId: entity.userId,
        gender: entity.gender,
        dob: entity.dob,
        location: entity.location,
        interests: entity.interests,
        languages: entity.languages);
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
          dob == other.dob &&
          location == other.location &&
          interests == other.interests &&
          languages == other.languages;

  @override
  String toString() {
    return 'UserProfile{userId: $userId, gender: $gender, dob: $dob, location: $location, '
        'interests: $interests, languages: $languages}';
  }
}
