import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';
import 'package:swiftvote/widgets/loading_indicator.dart';
import 'package:swiftvote/widgets/vote_page/vote_item.dart';
import 'package:swiftvote/utils/routes.dart';

class VoteWidget extends StatelessWidget {
  VoteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoteBloc, VoteState>(
      builder: (context, state) {
        if (state is VotesLoading) {
          return LoadingIndicator(key: SwiftvoteWidgetKeys.loadingIndicator);
        } else if (state is VotesLoaded) {
          final votes = state.votes;
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
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 5),
                        ),
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
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              125, 125, 125, 1))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      votes[1].tags[0],
                                      style: SwiftvoteTheme.voteTagsTextStyle,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(2.0, 0, 2.0, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              125, 125, 125, 1))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      votes[1].tags[1],
                                      style: SwiftvoteTheme.voteTagsTextStyle,
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
                                  votes[1].title,
                                  style: SwiftvoteTheme.largeTitleTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ), // Vote Title
                        VoteItem(
                          vote: votes[1], // THIS SHOULD FETCH WITH ID
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'Pass',
                              style: TextStyle(fontSize: 20),
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
                            color: SwiftvoteTheme.primaryColor,
                            splashColor: SwiftvoteTheme.primaryColorAccent,
                            focusColor: SwiftvoteTheme.primaryColorAccent,
                            highlightColor: SwiftvoteTheme.primaryColorAccent,
                            hoverColor: SwiftvoteTheme.primaryColorAccent,
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
