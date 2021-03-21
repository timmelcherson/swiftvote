import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities.dart';
import 'package:swiftvote/data/entities/vote_comment_entity.dart';

@immutable
class VoteComment {
  final String content;
  final DateTime createdAt;

  const VoteComment({
    this.content,
    this.createdAt,
  });

  VoteComment copyWith(
    String id,
    String content,
  ) {
    return VoteComment(
      content: content ?? this.content,
    );
  }

  @override
  int get hashCode => createdAt.hashCode | content.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoteComment && runtimeType == other.runtimeType && createdAt == other.createdAt;

  @override
  String toString() {
    return 'VoteComment{content: $content, createdAt: $createdAt}';
  }

  Map<String, Object> toMap() {
    return {
      "createdAt": createdAt,
      "content": content,
    };
  }

  static VoteComment fromMap(Map<String, Object> map) {

    VoteComment entity = VoteComment(
      content: map["content"] as String,
      createdAt: DateTime.parse(map["createdAt"] as String),
    );

    print('CREATED ENTITY');
    print(entity);
    print('%%%%%%%%%%%%%%%%%');
    return entity;
  }

  static VoteComment fromSnapshot(DocumentSnapshot snap) {
    print('FROM SNAPSHOT ----------');
    print(DateTime.fromMillisecondsSinceEpoch((snap.get('createdAt') as Timestamp).millisecondsSinceEpoch));
    print(snap.get('createdAt').runtimeType);
    return VoteComment(
      createdAt: DateTime.fromMillisecondsSinceEpoch((snap.get('createdAt') as Timestamp).millisecondsSinceEpoch),
      content: snap.get('content') as String,
    );
  }
}
