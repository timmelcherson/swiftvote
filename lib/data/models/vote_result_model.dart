import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities.dart';

@immutable
class VoteResult {
  final String voterId;
  final int votedOptionIndex;
  final String voterGender;
  final String voterAge;

  const VoteResult({
    this.voterId,
    this.voterAge,
    this.voterGender,
    this.votedOptionIndex,
  });

  VoteResult copyWith(
    String voterId,
    int votedOptionIndex,
    String voterGender,
    int voterAge,
  ) {
    return VoteResult(
      voterAge: voterAge ?? this.voterAge,
      voterGender: voterGender ?? this.voterGender,
      votedOptionIndex: votedOptionIndex ?? this.votedOptionIndex,
    );
  }

  Map<String, Object> toMap() {
    return {
      "voterId": this.voterId,
      "voterAge": this.voterAge,
      "voterGender": this.voterGender,
      "votedOptionIndex": this.votedOptionIndex,
    };
  }

  static VoteResult fromMap(Map<String, Object> map) {
    VoteResult entity = VoteResult(
      voterId: map["voterId"] as String,
      voterAge: map["voterAge"] as String,
      voterGender: map["voterGender"] as String,
      votedOptionIndex: map["voterAge"] as int,
    );
    return entity;
  }

  static VoteResult fromSnapshot(DocumentSnapshot snap) {
    return VoteResult(
      voterId: snap.id,
      voterAge: snap.get('voterAge') as String,
      voterGender: snap.get('voterGender') as String,
      votedOptionIndex: snap.get('votedOptionIndex') as int,
    );
  }
}
