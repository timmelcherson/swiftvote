import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:swiftvote/data/entities.dart';
import 'package:uuid/uuid.dart';

@immutable
class Vote {
  final String id;
  final String title;
  final String author;
  final List<String> category;
  final String sponsor;
  final List<String> voteOptions;
  final List<int> votes;
  final List<String> tags;

  const Vote(
      {this.id,
      this.title,
      this.author,
      this.category,
      this.sponsor,
      this.voteOptions,
      this.votes,
      this.tags});

  Vote copyWith(String id, String title, String author, String category,
      List<String> voteOptions, List<int> votes, List<String> tags) {
    return Vote(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      sponsor: sponsor ?? this.sponsor,
      voteOptions: voteOptions ?? this.voteOptions,
      votes: votes ?? this.votes,
      tags: tags ?? this.tags,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vote && runtimeType == other.runtimeType && id == other.id;

  @override
  String toString() {
    return 'Vote{id: $id, title: $title, author: $author, category: $category, sponsor: $sponsor, voteOptions: $voteOptions, votes: $votes, tags: $tags}';
  }

  VoteEntity toEntity() {
    return VoteEntity(
        id, title, author, category, sponsor, voteOptions, votes, tags);
  }

  static Vote fromEntity(VoteEntity entity) {
    return Vote(
        id: entity.id,
        title: entity.title,
        author: entity.author,
        category: entity.category,
        sponsor: entity.sponsor,
        voteOptions: entity.voteOptions,
        votes: entity.votes,
        tags: entity.tags);
  }
}
