import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftvote/data/entities.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';

class VoteRepository {
  final voteCollection = FirebaseFirestore.instance.collection('votes');

  Future<void> addNewVote(Vote vote) async {
    try {
      await voteCollection.add(vote.toEntity().toDocument());
      // DocumentReference docRef = await voteCollection.add(vote.toEntity().toDocument());
      // if (docRef != null) {
      //   vote.voteOptions.asMap().forEach((index, voteOption) {
      //     VoteResult voteResult = VoteResult(
      //       totalVotes: 0,
      //       femaleVotes: 0,
      //       maleVotes: 0,
      //       unknownGenderVotes: 0,
      //     );
      //     voteCollection
      //         .doc(vote.id)
      //         .collection('vote_results')
      //         .doc(index.toString())
      //         .set(voteResult.toEntity().toDocument()); // add each vote option
      //   });
      // }
    } catch (error) {
      print("Could not add vote, got error: $error");
    }
  }

  Future<void> updateVote(Vote vote) async {
    return voteCollection.doc(vote.id).update(vote.toEntity().toDocument());
  }

  Future<void> deleteVote(Vote vote) async {
    return voteCollection.doc(vote.id).delete();
  }

  Future<List<VoteResult>> getVoteResultsByVoteId(String voteId) async {
    // print('voteRepository getVoteResultsByVoteId for id: $voteId');
    return await voteCollection
        .doc(voteId)
        .collection('vote_results')
        .get()
        .then((querySnapshot) => querySnapshot.docs.map((doc) {
              return VoteResult.fromEntity(VoteResultEntity.fromSnapshot(doc));
            }).toList())
        .catchError((error) {
      print('Got error trying to fetch vote results: $error');
    });
    // VoteResult.fromEntity(VoteResultEntity.fromSnapshot(voteResult))
  }

  Future<List<Vote>> getVotesByCategory(String category) async {
    print('getVotesByCategory: $category');
    QuerySnapshot querySnapshot =
        await voteCollection.where('categories', arrayContains: category).limit(5).get().catchError((error) {
      print('query got error: $error');
    });
    print('got query snapshot of size: ${querySnapshot.size}');
    querySnapshot.docs.map((item) => print(item));
    //   .snapshots().map((snapshot) => snapshot.docs.map((vote) {
    // Vote.fromEntity(VoteEntity.fromSnapshot(snapshot))
    // }));
  }

  // Future<List<Vote>> getVotesByTitle(String searchQuery) async {
  //   QuerySnapshot qSnaps = await voteCollection.where("title", whereIn: searchQuery).get();
  //   print(qSnaps);
  //   .snapshots().map((snapshot) => snapshot.docs.map((vote) {
  // Vote.fromEntity(VoteEntity.fromSnapshot(snapshot))
  // }));
  // }

  Stream<List<Vote>> getVotes() {
    return voteCollection.limit(20).snapshots(includeMetadataChanges: true).map((snapshot) {
      print('GTOM FROM CACHEEEEE??? : ${snapshot.metadata.isFromCache}');
      return snapshot.docs.map((vote) {
        return Vote.fromEntity(VoteEntity.fromSnapshot(vote));
      }).toList();
    });
  }
}
