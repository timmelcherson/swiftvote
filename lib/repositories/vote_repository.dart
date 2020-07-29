import 'package:flutter/cupertino.dart';
import 'package:swiftvote/utils/file_storage.dart';

class VoteRepository {
  final FileStorage fileStorage;

  const VoteRepository({
    @required this.fileStorage,
  });

  Future<List<Vote>> saveVotes() async {
    try {
      return await fileStorage.loadTodos();
    } catch(e) {
      e.
    }
  }
}
