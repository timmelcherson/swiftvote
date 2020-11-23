import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities.dart';

@immutable
class Vote {
  final String id;
  final String title;
  final String author;
  final List<String> categories;
  final String sponsor;
  final List<String> voteOptions;
  final List<int> votes;
  final List<String> tags;

  const Vote(
      {this.id,
      this.title,
      this.author,
      this.categories,
      this.sponsor,
      this.voteOptions,
      this.votes,
      this.tags});

  Vote copyWith(String id, String title, String author, String categories,
      List<String> voteOptions, List<int> votes, List<String> tags) {
    return Vote(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      categories: categories ?? this.categories,
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
    return 'Vote{id: $id, title: $title, author: $author, categories: $categories, sponsor: $sponsor, voteOptions: $voteOptions, votes: $votes, tags: $tags}';
  }

  VoteEntity toEntity() {
    return VoteEntity(
        id, title, author, categories, sponsor, voteOptions, votes, tags);
  }

  static Vote fromEntity(VoteEntity entity) {
    return Vote(
        id: entity.id,
        title: entity.title,
        author: entity.author,
        categories: entity.categories,
        sponsor: entity.sponsor,
        voteOptions: entity.voteOptions,
        votes: entity.votes,
        tags: entity.tags);
  }
}
