import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:swiftvote/data/entities.dart';

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  Future<List<VoteEntity>> loadVotes() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final votes = (json['votes'])
        .map<VoteEntity>((vote) => VoteEntity.fromJson(vote))
        .toList();
    return votes;
  }

  Future<File> saveVotes(List<VoteEntity> votes) async {
    final file = await _getLocalFile();
    return file.writeAsString(JsonEncoder().convert({
      'votes': votes.map((vote) => vote.toJson()).toList(),
    }));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getLocalFile() async {
    final dir = await _localPath;
    return File('$dir/$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
