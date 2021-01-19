import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VoteEntity extends Equatable {
  final String id;
  final String title;
  final String author;
  final List<String> categories;
  final String sponsor;
  final List<String> voteOptions;
  final int totalVotes;
  final List<String> tags;

  const VoteEntity(
      {this.id,
      this.title,
      this.author,
      this.categories,
      this.sponsor,
      this.voteOptions,
      this.totalVotes,
      this.tags});

  @override
  List<Object> get props => [
        id,
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
    return 'VoteEntity{id: $id, title: $title, author: $author, categories: $categories, '
        'sponsor: $sponsor, voteOptions: $voteOptions, totalVotes: $totalVotes, tags: $tags}';
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "title": title,
      "author": author,
      "categories": categories,
      "sponsor": sponsor,
      "voteOptions": voteOptions,
      "totalVotes": totalVotes,
      "tags": tags,
    };
  }

  static VoteEntity fromJson(Map<String, Object> json) {
    List<String> voteOptionsList = new List<String>.from(json["voteOptions"]);
    List<String> tagsList = new List<String>.from(json["tags"]);
    List<String> categoryList = new List<String>.from(json["category"]);

    return VoteEntity(
      id: json["id"] as String,
      title: json["title"] as String,
      author: json["author"] as String,
      categories: categoryList,
      sponsor: json["sponsor"] as String,
      voteOptions: voteOptionsList,
      totalVotes: json["totalVotes"],
      tags: tagsList,
    );
  }

  static VoteEntity fromSnapshot(DocumentSnapshot snap) {
    List<String> _voteOptions = new List<String>.from(snap.get('voteOptions'));
    List<String> _tags = new List<String>.from(snap.get('tags'));
    List<String> _categories = new List<String>.from(snap.get('categories'));

    return VoteEntity(
      id: snap.id,
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
