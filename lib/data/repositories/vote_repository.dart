import 'dart:async';
import 'package:swiftvote/data/models.dart';

abstract class VoteRepository {

  Future<void> addNewVote(Vote vote);

  Future<void> deleteVote(Vote vote);

  Future<void> updateVote(Vote vote);

  Stream<List<Vote>> getVotes();
}
