import 'package:flutter/material.dart';
import 'package:swiftvote/data/entities.dart';

@immutable
class VoteResult {

  final String voteResultId;
  final int totalVotes;
  final int maleVotes;
  final int femaleVotes;
  final int unknownGenderVotes;

  const VoteResult({
    this.voteResultId,
    this.totalVotes,
    this.maleVotes,
    this.femaleVotes,
    this.unknownGenderVotes,
  });

  VoteResult copyWith(String voteResultId, int totalVotes, int maleVotes, int femaleVotes, int unknownGenderVotes) {
    return VoteResult(
      voteResultId: voteResultId ?? this.voteResultId,
      totalVotes: totalVotes ?? this.totalVotes,
      maleVotes: maleVotes ?? this.maleVotes,
      femaleVotes: femaleVotes ?? this.femaleVotes,
      unknownGenderVotes: unknownGenderVotes ?? this.unknownGenderVotes,
    );
  }


  VoteResultEntity toEntity() {
    return VoteResultEntity(
      totalVotes: totalVotes,
      maleVotes: maleVotes,
      femaleVotes: femaleVotes,
      unknownGenderVotes: unknownGenderVotes,
    );
  }

  static VoteResult fromEntity(VoteResultEntity entity) {
    return VoteResult(
      totalVotes: entity.totalVotes,
      maleVotes: entity.maleVotes,
      femaleVotes: entity.femaleVotes,
      unknownGenderVotes: entity.unknownGenderVotes,
    );
  }
}
