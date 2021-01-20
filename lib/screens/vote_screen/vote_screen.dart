import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/vote_screen/vote_barrel.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/widget_keys.dart';

typedef OnResultWidgetCallback = Function(bool showResultWidget);

class VoteScreen extends StatefulWidget {
  final Vote vote;

  VoteScreen({Key key, this.vote}) : super(key: key ?? Keys.voteWidget);

  @override
  State createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  VoteBloc _voteBloc;
  Vote _vote;
  bool _showResults;

  @override
  void initState() {
    super.initState();
    _voteBloc = BlocProvider.of(context);
    _showResults = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MainNavBar(),
      body: BlocBuilder<VoteBloc, VoteState>(
        builder: (context, state) {
          if (state is VotesLoadingState) {
            print(state);
            return LoadingIndicator(key: Keys.loadingIndicator);
          } else if (state is VotesLoadedState) {
            if (state.votes.length == 0 || state.votes.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have viewed all votes, well jobbed!'),
                  FlatButton(
                    child: Text('Reset?'),
                    color: Colors.blue[200],
                    onPressed: () {
                      _voteBloc.add(ResetVotesEvent(state.fullVoteList));
                    },
                  ),
                ],
              );
            }

            _vote = widget.vote ?? state.votes[0];

            return _showResults
                ? VoteResultWidget(vote: _vote)
                : VotePollerWidget(
                    vote: _vote,
                    votedCallback: (int voteIndex) => voteReceived(voteIndex),
                    votePassedCallback: () {
                      votePassed(state.votes);
                    },
                  );
          } else if (state is VotesEmptyState) {
            return Center(
              child: Text('You have viewed all votes, well jobbed!'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void votePassed(List currentVotesInState) {
    print('CALLBACK votePassed');
    _voteBloc.add(PassVoteEvent(currentVotesInState));
    setState(() {
      print('setting state');
    });
    // var freeIndexList = Iterable.generate(votesLength).toList();
    // freeIndexList.removeAt(_randomIndex);
    // int newRandomIndex = Random().nextInt(freeIndexList.length);
    // setState(() {
    //   _randomIndex = newRandomIndex;
    // });
  }

  void voteReceived(int voteIndex) {
    _voteBloc.add(IncreaseVoteScoreEvent(_vote, voteIndex));
    setState(() {
      _showResults = true;
    });
  }

  fadeOutWidget() {
    setState(() {});
  }
}
