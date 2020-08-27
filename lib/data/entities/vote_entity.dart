

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VoteEntity extends Equatable {

  final String id;
  final String title;
  final String author;
  final List<String> voteOptions;
  final List<int> votes;
  final List<String> tags;

  const VoteEntity(this.id, this.title, this.author, this.voteOptions, this.votes,
      this.tags);

  @override
  List<Object> get props => [id, title, author, voteOptions, votes, tags];

  @override
  String toString() {
    return 'VoteEntity{id: $id, title: $title, author: $author, voteOptions: $voteOptions, votes: $votes, tags: $tags}';
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

  static VoteEntity fromJson(Map<String, Object> json) {
    List<String> voteOptionsList = new List<String>.from(json["voteOptions"]);
    List<int> votesList = new List<int>.from(json["votes"]);
    List<String> tagsList = new List<String>.from(json["tags"]);

    VoteEntity vote = VoteEntity(json["id"] as String, json["title"] as String,
        json["author"] as String, voteOptionsList, votesList, tagsList);

    return vote;
  }

  static VoteEntity fromSnapshot(DocumentSnapshot snap) {
    return VoteEntity(
      snap.get('id'),
      snap.get('title'),
      snap.get('author'),
      snap.get('voteOptions'),
      snap.get('votes'),
      snap.get('tags'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'title': title,
      'author': author,
      'voteOptions': voteOptions,
      'votes': votes,
      'tags': tags,
    };
  }
}