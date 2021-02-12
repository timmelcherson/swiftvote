import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/widget_keys.dart';

typedef VoteReceivedCallback = Function(int index);

class VotePollerWidget extends StatelessWidget {
  final VoidCallback votePassedCallback;
  final VoteReceivedCallback votedCallback;
  final Vote vote;

  VotePollerWidget(
      {@required this.vote, @required this.votePassedCallback, @required this.votedCallback});

  Widget voteItem(String optionText, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            optionText,
            style: TextThemes.MEDIUM_DARK_GRAY,
          ),
          onPressed: () => {
            // Navigator.of(context).pushNamed(Routes.voteResult)
            votedCallback(index)
          },
          color: ColorThemes.OFF_WHITE,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
      height: MediaQuery.of(context).size.height,
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Container(
                key: Key(vote.id),
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(2.0, 0, 2.0, 0),
                              decoration: DecorationThemes.categoryBorder,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  vote.categories[0],
                                  style: TextThemes.FOOTNOTE_CHARCOAL_GRAY,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            vote.title,
                            overflow: TextOverflow.clip,
                            style: TextThemes.HUGE_OFF_WHITE,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < vote.voteOptions.length; i++)
                          voteItem(vote.voteOptions[i], i)
                      ],
                      // children: vote.voteOptions.asMap().map((index, value) => voteItem(index, value)).values.toList();
                    ),
                    // VoteItem(
                    //   vote: vote,
                    // ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          // BlocProvider.of<VoteBloc>(context)
                          //     .add(VotesUpdatedEvent(state.votes, state.randomIndex));
                          votePassedCallback();
                        },
                        child: Center(
                          child: Text(
                            'pass',
                            style: TextThemes.SMALL_WHITE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(Routes.ADD_VOTE);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 36,
                      ),
                      padding: EdgeInsets.all(0),
                      color: ColorThemes.PRIMARY_BLUE,
                      splashColor: ColorThemes.DEEP_MARINE_BLUE,
                      focusColor: ColorThemes.DEEP_MARINE_BLUE,
                      highlightColor: ColorThemes.DEEP_MARINE_BLUE,
                      hoverColor: ColorThemes.DEEP_MARINE_BLUE,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
