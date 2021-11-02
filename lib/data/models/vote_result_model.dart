import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class VoteResult {
  final String voterId;
  final int votedOptionIndex;
  final String voterGender;
  final int voterAge;

  const VoteResult({
    required this.voterId,
    required this.voterAge,
    required this.voterGender,
    required this.votedOptionIndex,
  });

  VoteResult copyWith({
    required String voterId,
    required int votedOptionIndex,
    required String voterGender,
    required int voterAge,
  }) {
    return VoteResult(
      voterId: voterId,
      voterAge: voterAge,
      voterGender: voterGender,
      votedOptionIndex: votedOptionIndex,
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
      voterAge: map["voterAge"] as int,
      voterGender: map["voterGender"] as String,
      votedOptionIndex: map["voterAge"] as int,
    );
    return entity;
  }

  static VoteResult fromSnapshot(DocumentSnapshot snap) {
    return VoteResult(
      voterId: snap.id,
      voterAge: snap.get('voterAge') as int,
      voterGender: snap.get('voterGender') as String,
      votedOptionIndex: snap.get('votedOptionIndex') as int,
    );
  }
}
