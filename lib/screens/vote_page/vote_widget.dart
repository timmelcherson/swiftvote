import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/screens/vote_page/vote_barrel.dart';
import 'package:swiftvote/themes/decoration_themes.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/widgets/loading_indicator.dart';
import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/widgets/widgets.dart';

class VoteWidget extends StatelessWidget {
  final Vote vote;

  VoteWidget({Key key, this.vote}) : super(key: key ?? SwiftvoteWidgetKeys.voteWidget);

//  Random _randomIndex;
//  VoteBloc _voteBloc;
//   Vote _passedVote;
//
// //  @override
//   void initState() {
//     super.initState();
//     _passedVote ??= widget.vote;
//   } //  VoteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Vote _passedVote = ModalRoute.of(context).settings.arguments;

    // print('_passedVote: $_passedVote');
    return BlocBuilder<VoteBloc, VoteState>(
      builder: (context, state) {
        if (state is VotesLoadingState) {
          return LoadingIndicator(key: SwiftvoteWidgetKeys.loadingIndicator);
        } else if (state is VotesLoadedState) {
          // final index = state.randomIndex;
          final _vote = vote ?? state.votes[state.randomIndex];





          return Container(
            margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      boxShadow: [
                        DecorationThemes.cardBoxShadow,
                      ],
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(2.0, 0, 2.0, 0),
                                  decoration: DecorationThemes.categoryBorder,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      _vote.category[0],
                                      style: TextThemes.voteTagsTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), // Related tags
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _vote.title,
                                  style: TextThemes.largeTitleTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ), // Vote Title
                        VoteItem(
                          vote: _vote,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<VoteBloc>(context)
                                  .add(VotesUpdatedEvent(state.votes, state.randomIndex));
                              Navigator.of(context).pushReplacementNamed(Routes.home);
//                              setState(() {
//                                print("setting state");
//                              });
                            },
                            child: Center(
                              child: Text(
                                'Pass',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(12),
                        child: ButtonTheme(
                          minWidth: 40,
                          height: 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pushNamed(Routes.addVoteSCreen);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 36,
                            ),
                            padding: EdgeInsets.all(0),
                            color: ColorThemes.primaryColor,
                            splashColor: ColorThemes.primaryColorAccent,
                            focusColor: ColorThemes.primaryColorAccent,
                            highlightColor: ColorThemes.primaryColorAccent,
                            hoverColor: ColorThemes.primaryColorAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
