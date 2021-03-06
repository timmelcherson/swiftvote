import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/vote_screen/vote_active_item.dart';
import 'package:swiftvote/screens/vote_screen/vote_history_item.dart';
import 'package:swiftvote/constants/widget_keys.dart';

typedef OnResultWidgetCallback = Function(bool showResultWidget);

class VoteScreen extends StatefulWidget {
  final Vote vote;

  VoteScreen({Key key, this.vote}) : super(key: key ?? Keys.voteWidget);

  @override
  State createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> with TickerProviderStateMixin {
  VoteBloc _voteBloc;
  Vote _vote;
  bool _showResults = false;
  ScrollController _controller;
  AnimationController _animationController;
  final Animatable<double> _fadeOutTween = Tween<double>(
    begin: 1.0,
    end: 0.0,
  );

  @override
  void initState() {
    _voteBloc = BlocProvider.of(context);
    _controller = ScrollController();
    _controller.addListener(() => scrollHandler());
    _animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    print(_animationController.value);
    _animationController.drive(_fadeOutTween);

    super.initState();
  }

  void _scrollToBottom() {
    _controller.jumpTo(0.0);
  }

  void scrollHandler() {
    if (_controller.position.pixels <= 0) {
      print('BOTTOM');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: MainNavBar(),
      body: SafeArea(
        child: BlocBuilder<VoteBloc, VoteState>(
          builder: (context, state) {
            if (state is VotesLoadingState) {
              return LoadingIndicator(key: Keys.loadingIndicator);
            }

            if (state is VotesLoadedState) {
              return ListView.builder(
                shrinkWrap: true,
                reverse: true,
                controller: _controller,
                itemCount: state.votes.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return VoteActiveItem(vote: state.votes[index]);
                  } else {
                    return VoteHistoryItem(vote: state.votes[index]);
                  }
                },
              );
            }

            if (state is VotesEmptyState) {
              return Center(
                child: Text('You have viewed all votes, well jobbed!'),
              );
            }
            return LoadingIndicator();
          },
        ),
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
}
