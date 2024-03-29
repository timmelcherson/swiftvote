import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities/index.dart';

@immutable
class Vote {
  final String id;
  final String title;
  final String author;
  final List<String> categories;
  final String sponsor;
  final List<String> voteOptions;
  final int totalVotes;
  final List<String> tags;

  const Vote({
    required this.id,
    required this.title,
    required this.author,
    required this.categories,
    required this.sponsor,
    required this.voteOptions,
    required this.totalVotes,
    required this.tags,
  });

  Vote copyWith(String id, String title, String author, List<String> categories, List<String> voteOptions,
      int totalVotes, List<String> tags) {
    return Vote(
      id: id,
      title: title,
      author: author,
      categories: categories,
      sponsor: sponsor,
      voteOptions: voteOptions,
      totalVotes: totalVotes,
      tags: tags,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Vote && runtimeType == other.runtimeType && id == other.id;

  @override
  String toString() {
    return 'Vote{id: $id, title: $title, author: $author, categories: $categories, sponsor: $sponsor, '
        'voteOptions: $voteOptions, totalVotes: $totalVotes, tags: $tags}';
  }

  VoteEntity toEntity() {
    return VoteEntity(
      title: title,
      author: author,
      categories: categories,
      sponsor: sponsor,
      voteOptions: voteOptions,
      totalVotes: totalVotes,
      tags: tags,
    );
  }

  static Vote fromSnapshot({required String id, required DocumentSnapshot snap}) {
    List<String> _voteOptions = new List<String>.from(snap.get('voteOptions'));
    List<String> _tags = new List<String>.from(snap.get('tags'));
    List<String> _categories = new List<String>.from(snap.get('categories'));

    return Vote(
      id: id,
      title: snap.get('title'),
      author: snap.get('author'),
      categories: _categories,
      sponsor: snap.get('sponsor'),
      voteOptions: _voteOptions,
      totalVotes: snap.get('totalVotes'),
      tags: _tags,
    );
  }

  static Vote fromQuerySnapshot(QueryDocumentSnapshot snap) {
    List<String> _voteOptions = new List<String>.from(snap.get('voteOptions'));
    List<String> _tags = new List<String>.from(snap.get('tags'));
    List<String> _categories = new List<String>.from(snap.get('categories'));

    return Vote(
      id: snap.get('id'),
      title: snap.get('title'),
      author: snap.get('author'),
      categories: _categories,
      sponsor: snap.get('sponsor'),
      voteOptions: _voteOptions,
      totalVotes: snap.get('totalVotes'),
      tags: _tags,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'categories': categories,
      'sponsor': sponsor,
      'voteOptions': voteOptions,
      'totalVotes': totalVotes,
      'tags': tags,
    };
  }
}
