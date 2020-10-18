import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/vote_page/vote_barrel.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';

typedef OnResultWidgetCallback = Function(bool showResultWidget);

class VoteWidget extends StatefulWidget {
  final Vote vote;

  VoteWidget({Key key, this.vote}) : super(key: key ?? SwiftvoteWidgetKeys.voteWidget);

  @override
  State createState() {
    return _VoteWidgetState();
  }
}

class _VoteWidgetState extends State<VoteWidget> {
  bool _hasVoteFromArgs;
  bool _showResults;
  bool _showPoller;

  double containerOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _hasVoteFromArgs = widget.vote != null ? true : false;
    _showPoller = true;
    _showResults = false;
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<VoteBloc, VoteState>(
      builder: (context, state) {
        if (state is VotesLoadingState) {
          print(state);
          return LoadingIndicator(key: SwiftvoteWidgetKeys.loadingIndicator);
        } else if (state is VotesLoadedState) {

          final _vote = widget.vote ?? state.votes[state.randomIndex];

          return _showPoller
              ? VotePollerWidget(vote: _vote, votedCallback: voteReceived, votePassedCallback: votePassed,)
              : VoteResultWidget();
        } else {
          return Container();
        }
      },
    );
  }

  void votePassed() {
    print('CALLBACK votePassed');
  }

  void voteReceived() {
    print('CALLBACK voteReceived');
    setState(() {
      _showResults = true;
      _showPoller = false;
    });
  }

  fadeOutWidget() {
    setState(() {});
  }
}
