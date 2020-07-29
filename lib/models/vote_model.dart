import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Vote extends Equatable {

  final String id;
  final String title;
  final String author;
  final List<String> voteOptions;
  final List<int> votes;
  final List<String> tags;


  Vote(
      String id,
      this.title,
      this.author,
      this.voteOptions,
      this.votes,
      this.tags
      ) : this.id = id ?? Uuid().v4();

  @override
  List<Object> get props => [id, title, author, voteOptions, votes, tags];

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Vote &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  String toString() {
    return 'Vote{id: $id, title: $title, author: $author, voteOptions: $voteOptions, votes: $votes, tags: $tags}';
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "title": title,
      "author": author,
      "voteOptions": voteOptions,
      "votes": votes,
      "tags": tags,
    };
  }

  static Vote fromJson(Map<String, Object> json) {
    return Vote(
      json["id"] as String,
      json["title"] as String,
      json["author"] as String,
      json["voteOptions"] as List<String>,
      json["votes"] as List<int>,
      json["tags"] as List<String>,
    );
  }
}