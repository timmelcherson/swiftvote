import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftvote/data/entities.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';

class VoteRepository {
  final voteCollection = FirebaseFirestore.instance.collection('votes');

  Future<void> addNewVote(Vote vote) {
    return voteCollection.add(vote.toEntity().toDocument());
  }

  Future<void> updateVote(Vote vote) {
    return voteCollection.doc(vote.id).update(vote.toEntity().toDocument());
  }

  Future<void> deleteVote(Vote vote) {
    return voteCollection.doc(vote.id).delete();
  }

  Stream<List<Vote>> getVotes() {
    print("GETTING VOTES FROM FIREBASE");
    print(voteCollection.snapshots());
    return voteCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Vote.fromEntity(VoteEntity.fromSnapshot(doc)))
        .toList());
  }
}
