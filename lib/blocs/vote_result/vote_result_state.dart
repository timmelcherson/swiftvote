import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/data/models/index.dart';

@immutable
abstract class VoteResultState extends Equatable {
  const VoteResultState();

  @override
  List<Object> get props => [];
}

@immutable
class VoteResultInitialState extends VoteResultState {}

@immutable
class VoteResultReadyState extends VoteResultState {
  final Vote vote;

  const VoteResultReadyState({required this.vote});

  // int get getVoteAmountOptionOne => voteResults.where((vote) => vote.votedOptionIndex == 0).length;
  // int get getVoteAmountOptionTwo => voteResults.where((vote) => vote.votedOptionIndex == 1).length;
  // double get getOptionOnePart => getVoteAmountOptionOne / voteResults.length;
  // double get getOptionTwoPart => getVoteAmountOptionTwo / voteResults.length;
  //
  // int get getFemaleTotalVotes => voteResults.where((vote) => vote.voterGender == 'Female').length;
  // int get getFemaleOptionOneVotes => voteResults.where((vote) => vote.voterGender == 'Female' && vote.votedOptionIndex == 0).length;
  // int get getFemaleOptionTwoVotes => voteResults.where((vote) => vote.voterGender == 'Female' && vote.votedOptionIndex == 1).length;
  // double get getFemaleOptionOnePart => getFemaleOptionOneVotes / getFemaleTotalVotes;
  // double get getFemaleOptionTwoPart => getFemaleOptionTwoVotes / getFemaleTotalVotes;
  //
  // int get getMaleTotalVotes => voteResults.where((vote) => vote.voterGender == 'Male').length;
  // int get getMaleOptionOneVotes => voteResults.where((vote) => vote.voterGender == 'Male' && vote.votedOptionIndex == 0).length;
  // int get getMaleOptionTwoVotes => voteResults.where((vote) => vote.voterGender == 'Male' && vote.votedOptionIndex == 1).length;
  // double get getMaleOptionOnePart => getFemaleOptionOneVotes / getFemaleTotalVotes;
  // double get getMaleOptionTwoPart => getFemaleOptionTwoVotes / getFemaleTotalVotes;

  @override
  List<Object> get props => [vote];
}

@immutable
class VoteResultLoadFailState extends VoteResultState {}
