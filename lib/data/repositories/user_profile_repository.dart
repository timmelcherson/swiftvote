import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftvote/data/entities/user_profile_entity.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';

class UserProfileRepository {

  final _userProfileCollection = FirebaseFirestore.instance.collection('user_profiles');

  Future<void> addNewUserProfile(UserProfile userProfile) {
    print('CREATING A USER PROFILE');
    return _userProfileCollection.add(userProfile.toEntity().toDocument());
  }

  Future<void> updateUserProfile(UserProfile userProfile) {
    return _userProfileCollection
        .doc(userProfile.userId)
        .update(userProfile.toEntity().toDocument());
  }

  Future<void> deleteUserProfile(UserProfile userProfile) {
    return _userProfileCollection.doc(userProfile.userId).delete();
  }

  bool hasProfile(String id) {
    return _userProfileCollection.doc(id) == null;
  }

  Future<UserProfile> getUserProfileById(String id) {
    return _userProfileCollection.where('userId', isEqualTo: id).limit(1).get().then(
        (querySnapshot) =>
            UserProfile.fromEntity(UserProfileEntity.fromSnapshot(querySnapshot.docs.single)));
  }

  Stream<List<UserProfile>> getUserProfiles() {
    print("GETTING UserProfileS FROM FIREBASE");
    print(_userProfileCollection.snapshots());
    return _userProfileCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UserProfile.fromEntity(UserProfileEntity.fromSnapshot(doc)))
        .toList());
  }
}
