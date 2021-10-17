import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftvote/data/entities/user_profile_entitry.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/responses/BaseResponse.dart';

class UserProfileRepository {
  final _userProfileCollection =
      FirebaseFirestore.instance.collection('user_profiles');

  static final UserProfileRepository _userProfileRepository =
      UserProfileRepository._internal();

  factory UserProfileRepository() {
    return _userProfileRepository;
  }

  UserProfileRepository._internal();

  Future<BaseResponse> addNewUserProfile(
      {@required UserProfile userProfile}) async {
    bool _success = false;
    var _value;
    await _userProfileCollection
        .doc(userProfile.userId)
        .set(userProfile.toEntity().toDocument())
        .catchError((error) => _value = error);

    return BaseResponse(
      success: _success,
      value: _value,
    );
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    return _userProfileCollection
        .doc(userProfile.userId)
        .update(userProfile.toEntity().toDocument());
  }

  Future<void> deleteUserProfile(UserProfile userProfile) async {
    return _userProfileCollection.doc(userProfile.userId).delete();
  }

  Future<bool> hasProfile({@required String id}) async {
    return _userProfileCollection.doc(id) == null;
  }

  Future<UserProfile> fetchUserProfileById({@required String id}) async {
    return await _userProfileCollection.doc(id).get().then((snapshot) {
      return snapshot.exists
          ? UserProfile.fromEntity(UserProfileEntity.fromSnapshot(snapshot))
          : null;
    }).catchError((onError) {
      return null;
    });
  }

  Stream<List<UserProfile>> getUserProfiles() {
    return _userProfileCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            UserProfile.fromEntity(UserProfileEntity.fromSnapshot(doc)))
        .toList());
  }
}
