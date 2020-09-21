import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftvote/data/entities.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';

class FirebaseVoteRepository implements VoteRepository {
  final voteCollection = FirebaseFirestore.instance.collection('votes');

  @override
  Future<void> addNewVote(Vote vote) {
    return voteCollection.add(vote.toEntity().toDocument());
  }

  @override
  Future<void> updateVote(Vote vote) {
    return voteCollection.doc(vote.id).delete();
  }

  @override
  Future<void> deleteVote(Vote vote) {
    return voteCollection.doc(vote.id).update(vote.toEntity().toDocument());
  }

  @override
  Stream<List<Vote>> getVotes() {
    print("GETTING VOTES FROM FIREBASE");
    return voteCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Vote.fromEntity(VoteEntity.fromSnapshot(doc)))
        .toList());
  }


}
