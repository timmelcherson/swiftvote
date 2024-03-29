import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftvote/data/entities/index.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/data/repositories/index.dart';

class VoteRepository {
  final voteCollection = FirebaseFirestore.instance.collection('votes');

  Future<void> addNewVote({required VoteEntity entity}) async {
    try {
      await voteCollection.add(entity.toMap()).then((id) => id.toString());
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

  // Future<List<VoteResult>> getVoteResultsByVoteId(String voteId) async {
  //   // print('voteRepository getVoteResultsByVoteId for id: $voteId');
  //   return await voteCollection
  //       .doc(voteId)
  //       .collection('vote_results')
  //       .get()
  //       .then((querySnapshot) =>
  //       querySnapshot.docs.map((doc) {
  //         return VoteResult.fromEntity(VoteResultEntity.fromSnapshot(doc));
  //       }).toList())
  //       .catchError((error) {
  //     print('Got error trying to fetch vote results: $error');
  //   });
  //   // VoteResult.fromEntity(VoteResultEntity.fromSnapshot(voteResult))
  // }

  Future<List<Vote>> getVotesByCategory(String category) async {
    print('getVotesByCategory: $category');
    QuerySnapshot querySnapshot = await voteCollection
        .where('categories', arrayContains: category)
        .limit(20)
        .get()
        .catchError((error) {
      print('Got error fetching votes by category: $error');
    });

    return querySnapshot.docs.map((snap) {
      return Vote.fromQuerySnapshot(snap);
    }).toList();
  }

  // Future<List<Vote>> getVotesByTitle(String searchQuery) async {
  //   QuerySnapshot qSnaps = await voteCollection.where("title", whereIn: searchQuery).get();
  //   print(qSnaps);
  //   .snapshots().map((snapshot) => snapshot.docs.map((vote) {
  // Vote.fromEntity(VoteEntity.fromSnapshot(snapshot))
  // }));
  // }

  Stream<List<Vote>> getVotes() {
    return voteCollection
        .limit(5)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      print('GOT FROM CACHE??? : ${snapshot.metadata.isFromCache}');
      return snapshot.docs.map((snap) {
        print('SNAPID: ${snap.id}');
        return Vote.fromSnapshot(id: snap.id, snap: snap);
      }).toList();
    });
  }

  Stream<List<VoteComment>> getVoteCommentsByVoteId({required String voteId}) {
    print('getVoteCommentsByVoteId');
    return voteCollection
        .doc(voteId)
        .collection('comments')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return VoteComment.fromSnapshot(doc);
      }).toList();
    });
  }

  Future<void> addVoteComment({
    required String voteId,
    required VoteComment comment,
  }) async {
    try {
      await voteCollection
          .doc(voteId)
          .collection('comments')
          .add(comment.toMap());
    } catch (error) {
      print("Could not add vote, got error: $error");
    }
  }

  Future<bool> addVoteResult({
    required String userId,
    required String voteId,
    required VoteResult result,
  }) async {
    print('adding result: $result to vote with id: $voteId');
    try {
      // voteCollection.doc(voteId).collection('results').add(result.toMap());
      voteCollection
          .doc(voteId)
          .collection('results')
          .doc(userId)
          .set(result.toMap())
          .catchError((error) {
        print('Could not set result, got error: $error');
      });
      // _userProfileCollection.doc(userProfile.userId).set(userProfile.toEntity().toDocument());
      return true;
    } catch (error) {
      print('Could not add result, got error: $error');
      return false;
    }
  }

  Stream<List<VoteResult>> getVoteResultByVoteId({required String voteId}) {
    print('getVoteCommentsByVoteId');
    return voteCollection
        .doc(voteId)
        .collection('results')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return VoteResult.fromSnapshot(doc);
      }).toList();
    });
  }
}
