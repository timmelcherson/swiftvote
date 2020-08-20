import 'package:flutter/cupertino.dart';
import 'package:swiftvote/models/models.dart';
import 'package:swiftvote/utils/file_storage.dart';
import 'package:swiftvote/utils/web_client.dart';

class VoteRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const VoteRepository({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  Future<List<Vote>> loadVotes() async {
    try {
      return await fileStorage.loadVotes();
    } catch (e) {
      print(e);
      final votes = await webClient.fetchVotes();

      fileStorage.saveVotes(votes);

      return votes;
    }
  }

  Future saveVotes(List<Vote> votes) {
    return Future.wait<dynamic>([
      fileStorage.saveVotes(votes),
    ]);
  }
}
