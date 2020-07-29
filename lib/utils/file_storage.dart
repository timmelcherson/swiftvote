import 'dart:convert';
import 'dart:io';

import 'package:swiftvote/models/models.dart';


class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
      this.tag,
      this.getDirectory,
      );

  Future<List<Vote>> loadVotes() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final votes = (json['vote'])
        .map<Vote>((vote) => Vote.fromJson(vote))
        .toList();

    return votes;
  }

  Future<File> saveVotes(List<Vote> todos) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'votes': todos.map((todo) => todo.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}