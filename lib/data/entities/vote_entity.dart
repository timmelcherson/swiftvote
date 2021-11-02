import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// This class is the same as {Vote] but without the ID,
/// i.e. a vote to-be-posted
class VoteEntity extends Equatable {
  final String title;
  final String author;
  final List<String> categories;
  final String sponsor;
  final List<String> voteOptions;
  final int totalVotes;
  final List<String> tags;

  const VoteEntity({
    required this.title,
    required this.author,
    required this.categories,
    required this.sponsor,
    required this.voteOptions,
    required this.totalVotes,
    required this.tags,
  });

  @override
  List<Object> get props => [
        title,
        author,
        categories,
        sponsor,
        voteOptions,
        totalVotes,
        tags,
      ];

  @override
  String toString() {
    return 'VoteEntity{title: $title, author: $author, categories: $categories, '
        'sponsor: $sponsor, voteOptions: $voteOptions, totalVotes: $totalVotes, tags: $tags}';
  }

  Map<String, Object> toMap() {
    return {
      "title": title,
      "author": author,
      "categories": categories,
      "sponsor": sponsor,
      "voteOptions": voteOptions,
      "totalVotes": totalVotes,
      "tags": tags,
    };
  }

  static VoteEntity fromMap(Map<String, Object> map) {
    List<String> voteOptionsList = new List<String>.from(map["voteOptions"] as List<String>);
    List<String> tagsList = new List<String>.from(map["tags"] as List<String>);
    List<String> categoryList = new List<String>.from(map["category"] as List<String>);

    VoteEntity entity = VoteEntity(
      title: map["title"] as String,
      author: map["author"] as String,
      categories: categoryList,
      sponsor: map["sponsor"] as String,
      voteOptions: voteOptionsList,
      totalVotes: map["totalVotes"] as int,
      tags: tagsList,
    );

    print('CREATED ENTITY');
    print(entity);
    print('%%%%%%%%%%%%%%%%%');
    return entity;
  }

  static VoteEntity fromSnapshot(DocumentSnapshot snap) {
    List<String> _voteOptions = new List<String>.from(snap.get('voteOptions'));
    List<String> _tags = new List<String>.from(snap.get('tags'));
    List<String> _categories = new List<String>.from(snap.get('categories'));

    return VoteEntity(
      title: snap.get('title'),
      author: snap.get('author'),
      categories: _categories,
      sponsor: snap.get('sponsor'),
      voteOptions: _voteOptions,
      totalVotes: snap.get('totalVotes'),
      tags: _tags,
    );
  }

  static VoteEntity fromQuerySnapshot(QueryDocumentSnapshot snap) {
    List<String> _voteOptions = new List<String>.from(snap.get('voteOptions'));
    List<String> _tags = new List<String>.from(snap.get('tags'));
    List<String> _categories = new List<String>.from(snap.get('categories'));

    return VoteEntity(
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
