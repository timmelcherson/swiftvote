import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/screens/vote_page/vote_barrel.dart';
import 'package:swiftvote/themes/decoration_themes.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/widgets/loading_indicator.dart';
import 'package:swiftvote/utils/routes.dart';

class VoteWidget extends StatefulWidget {
  VoteWidget({Key key}) : super(key: key ?? SwiftvoteWidgetKeys.voteWidget);

  @override
  State createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
//  Random _randomIndex;
//  VoteBloc _voteBloc;

//  @override
//  void initState() {
//    super.initState();
//    _voteBloc = BlocProvider.of<VoteBloc>(context);
//    _randomIndex = Random();
//  } //  VoteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoteBloc, VoteState>(
      builder: (context, state) {
        if (state is VotesLoadingState) {
          return LoadingIndicator(key: SwiftvoteWidgetKeys.loadingIndicator);
        } else if (state is VotesLoadedState) {
          final index = state.randomIndex;
          final vote = state.votes[index];

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
                                      vote.category[0],
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
                                  vote.title,
                                  style: TextThemes.largeTitleTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ), // Vote Title
                        VoteItem(
                          vote: vote,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<VoteBloc>(context)
                                  .add(VotesUpdatedEvent(state.votes, index));
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
                              Navigator.pushNamed(context, Routes.addVoteSCreen);
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
