import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VoteCommentEntity extends Equatable {
  final String content;
  final String createdAt;

  const VoteCommentEntity({
    this.content,
    this.createdAt,
  });

  @override
  List<Object> get props => [
        createdAt,
        content
      ];

  @override
  String toString() {
    return 'VoteCommentEntity{createdAt: $createdAt, content: $content}';
  }

  Map<String, Object> toMap() {
    return {
      "createdAt": createdAt,
      "content": content,
    };
  }

  static VoteCommentEntity fromMap(Map<String, Object> map) {

    VoteCommentEntity entity = VoteCommentEntity(
      createdAt: map["createdAt"] as String,
      content: map["content"] as String,
    );

    print('CREATED ENTITY');
    print(entity);
    print('%%%%%%%%%%%%%%%%%');
    return entity;
  }

  static VoteCommentEntity fromSnapshot(DocumentSnapshot snap) {
    return VoteCommentEntity(
      createdAt: snap.get('createdAt'),
      content: snap.get('content'),
    );
  }

  static VoteCommentEntity fromQuerySnapshot(QueryDocumentSnapshot snap) {
    return VoteCommentEntity(
      createdAt: snap.get('createdAt'),
      content: snap.get('content'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'content': content,
      'createdAt': createdAt,
    };
  }
}
