import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftvote/data/entities/user_profile_entitry.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';

class UserProfileRepository {
  final _userProfileCollection =
      FirebaseFirestore.instance.collection('user_profiles');

  static final UserProfileRepository _userProfileRepository = UserProfileRepository._internal();

  factory UserProfileRepository() {
    return _userProfileRepository;
  }

  UserProfileRepository._internal();

  Future<String> addNewUserProfile(
      {@required String userId, String age, String gender, String location}) async {
    final doc = await _userProfileCollection.add({
      userId: userId,
      age: age,
      gender: gender,
      location: location,
    });
    return doc.id;
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    return _userProfileCollection
        .doc(userProfile.userId)
        .update(userProfile.toEntity().toDocument());
  }

  Future<void> deleteUserProfile(UserProfile userProfile) async {
    return _userProfileCollection.doc(userProfile.userId).delete();
  }

  Future<bool> hasProfile(String id) async {
    return _userProfileCollection.doc(id) == null;
  }

  Future<UserProfile> fetchUserProfileById({String id}) async {
    return await _userProfileCollection.doc(id).get().then((snapshot) {
      return snapshot.exists
          ? UserProfile.fromEntity(UserProfileEntity.fromSnapshot(snapshot))
          : null;
    }).catchError((onError) {
      print('COULD NOT FIND USERPROFILE IN FIRESTORE: $onError');
      return null;
    });
    // return UserProfile.fromEntity(UserProfileEntity.fromSnapshot(snapshot));
    // return _userProfileCollection
    //     .where('userId', isEqualTo: id)
    //     .limit(1)
    //     .get()
    //     .then((querySnapshot) => querySnapshot.size > 0
    //         ? UserProfile.fromEntity(UserProfileEntity.fromSnapshot(querySnapshot.docs.single))
    //         : null)
    //     .catchError((onError) {
    //   print('Query to getUserProfileById failed with message: $onError');
    // });
  }

  Stream<List<UserProfile>> getUserProfiles() {
    return _userProfileCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            UserProfile.fromEntity(UserProfileEntity.fromSnapshot(doc)))
        .toList());
  }
}
