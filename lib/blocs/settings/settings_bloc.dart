import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/explore/index.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/data/repositories/index.dart';
import './index.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final VoteRepository voteRepository;
  final UserProfileRepository userProfileRepository;
  final VoteBloc voteBloc;
  final UserProfileBloc userProfileBloc;

  bool _isUserProfileStateReady = false;
  bool _isVoteStateReady = false;

  SettingsBloc({
    @required this.voteRepository,
    @required this.userProfileRepository,
    @required this.voteBloc,
    @required this.userProfileBloc,
  }) : super(SettingsLoadingState()) {
    print('SettingsLoadingState');
    print('userProfileState: ${userProfileBloc.state}');
    print('voteState: ${voteBloc.state}');
    userProfileBloc.stream.listen((userProfileState) {
      if (userProfileState is UserProfileReadyState) {
        print('userProfileState IS READY: $userProfileState');
        _isUserProfileStateReady = true;

        if (voteBloc.state is VotesReadyState) {
          print('voteState IS READY 1: ${voteBloc.state}');
          add(
            LoadSettingsEvent(
              userProfile:
                  (userProfileBloc.state as UserProfileReadyState).userProfile,
              votes: (voteBloc.state as VotesReadyState).votes,
            ),
          );
        } else {
          voteBloc.stream.listen((voteState) {
            if (voteState is VotesReadyState) {
              print('voteState IS READY 2: ${voteBloc.state}');
              add(
                LoadSettingsEvent(
                  userProfile: (userProfileBloc.state as UserProfileReadyState)
                      .userProfile,
                  votes: (voteBloc.state as VotesReadyState).votes,
                ),
              );
            }
          });
        }
      }
    });
    // if (userProfileBloc.state is UserProfileReadyState &&
    //     voteBloc.state is VotesReadyState) {
    //   _isUserProfileStateReady = true;
    //   _isVoteStateReady = true;
    // } else if (userProfileBloc.state is UserProfileReadyState &&
    //     voteBloc.state.runtimeType != VotesReadyState) {
    //   print('NOW THIS IS CASE 2');
    //   voteBloc.stream.listen((voteState) {
    //     if (voteState is VotesReadyState) {
    //       print('voteState IS READY: $voteState');
    //       _isVoteStateReady = true;
    //     }
    //   });
    // } else if (userProfileBloc.state.runtimeType != UserProfileReadyState &&
    //     voteBloc.state is VotesReadyState) {
    //   userProfileBloc.stream.listen((userProfileState) {
    //     if (userProfileState is UserProfileReadyState) {
    //       print('userProfileState IS READY: $userProfileState');
    //       _isUserProfileStateReady = true;
    //     }
    //   });
    //   print('NOW THIS IS CASE 3');
    // } else {
    //   userProfileBloc.stream.listen((userProfileState) {
    //     if (userProfileState is UserProfileReadyState) {
    //       print('userProfileState IS READY: $userProfileState');
    //       _isUserProfileStateReady = true;
    //     }
    //   });
    //   voteBloc.stream.listen((voteState) {
    //     if (voteState is VotesReadyState) {
    //       print('voteState IS READY: $voteState');
    //       _isVoteStateReady = true;
    //     }
    //   });
    // }
  }

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LoadSettingsEvent) {
      yield* _mapLoadSettingsEventToState(event);
    }
  }

  Stream<SettingsState> _mapLoadSettingsEventToState(
      LoadSettingsEvent event) async* {

    print('*****************');
    print(event.votes);
    List<Vote> usersVotes =
        event.votes.where((vote) => vote.author == 'swiftvote').toList();

    print('Yielding SettingsReadyState with votes:');
    print(usersVotes);
    yield SettingsReadyState(votes: usersVotes, userProfile: event.userProfile);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
