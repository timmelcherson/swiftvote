import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftvote/data/entities.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';

class VoteRepository {
  final voteCollection = FirebaseFirestore.instance.collection('votes');

  Future<void> addNewVote(Vote vote) async {
    DocumentReference docRef = await voteCollection.add(vote.toEntity().toDocument());
    if (docRef != null) {
      vote.voteOptions.asMap().forEach((index, voteOption) {
        VoteResult voteResult = VoteResult();
        voteCollection
            .doc(vote.id)
            .collection('vote_results')
            .doc(index.toString())
            .set(voteResult.toEntity().toDocument()); // add each vote option
      });
    }
  }

  Future<void> updateVote(Vote vote) async {
    return voteCollection.doc(vote.id).update(vote.toEntity().toDocument());
  }

  Future<void> deleteVote(Vote vote) async {
    return voteCollection.doc(vote.id).delete();
  }

  Future<List<VoteResult>> getVoteResultsByVoteId(String voteId) async {
    print('voteRepository getVoteResultsByVoteId for id: $voteId');
    return await voteCollection
        .doc(voteId)
        .collection('vote_results')
        .get()
        .then((querySnapshot) => querySnapshot.docs.map((doc) {
              print(doc);
              print(VoteResultEntity.fromSnapshot(doc));
              print(VoteResult.fromEntity(VoteResultEntity.fromSnapshot(doc)));
              return VoteResult.fromEntity(VoteResultEntity.fromSnapshot(doc));
            }).toList())
        .catchError((error) {
      print('Got error trying to fetch vote results: $error');
    });
    // VoteResult.fromEntity(VoteResultEntity.fromSnapshot(voteResult))
  }

  Stream<List<Vote>> getVotes() {
    print("GETTING VOTES FROM FIREBASE");
    print(voteCollection.snapshots());
    return voteCollection.snapshots().map((snapshot) => snapshot.docs.map((vote) {
          print('%%%%%%%%%%%%%%% GOT VOTE');
          print(VoteEntity.fromSnapshot(vote));
          Vote v = Vote.fromEntity(VoteEntity.fromSnapshot(vote));
          print(v);
          return v;
        }).toList());
  }
}
