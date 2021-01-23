import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VoteResultEntity extends Equatable {

  final int totalVotes;
  final int maleVotes;
  final int femaleVotes;
  final int unknownGenderVotes;

  VoteResultEntity(
      {this.totalVotes = 0, this.maleVotes = 0, this.femaleVotes = 0, this.unknownGenderVotes = 0});

  @override
  List<Object> get props => [totalVotes, maleVotes, femaleVotes, unknownGenderVotes];

  @override
  String toString() {
    return 'VoteResultEntity{totalVotes: $totalVotes}';
  }

  Map<String, Object> toJson() {
    return {
      "totalVotes": totalVotes,
      "maleVotes": maleVotes,
      "femaleVotes": femaleVotes,
      "unknownGenderVotes": unknownGenderVotes,
    };
  }

  static VoteResultEntity fromJson(Map<String, Object> json) {
    return VoteResultEntity(
      totalVotes: json["totalVotes"] as int,
      maleVotes: json["maleVotes"] as int,
      femaleVotes: json["femaleVotes"] as int,
      unknownGenderVotes: json["unknownGenderVotes"] as int,
    );
  }

  static VoteResultEntity fromSnapshot(DocumentSnapshot snap) {
    return VoteResultEntity(
      totalVotes: snap.get('totalVotes'),
      maleVotes: snap.get('maleVotes'),
      femaleVotes: snap.get('femaleVotes'),
      unknownGenderVotes: snap.get('unknownGenderVotes'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'totalVotes': totalVotes,
      'maleVotes': maleVotes,
      'femaleVotes': femaleVotes,
      'unknownGenderVotes': unknownGenderVotes,
    };
  }
}
