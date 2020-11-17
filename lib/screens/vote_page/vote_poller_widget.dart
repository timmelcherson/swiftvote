import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/themes/themes.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/routes.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/swiftvote_widget_keys.dart';

typedef VoteReceivedCallback = Function(int index);

class VotePollerWidget extends StatelessWidget {
  final VoidCallback votePassedCallback;
  final VoteReceivedCallback votedCallback;
  final Vote vote;

  VotePollerWidget(
      {@required this.vote, @required this.votePassedCallback, @required this.votedCallback});

  Widget voteItem(String optionText, int index) {

    bool even = index % 2 == 0;
    Color bg = even ? ColorThemes.primaryColor : ColorThemes.secondaryColor;
    TextStyle textStyle = even ? TextThemes.mediumBrightTextStyle : TextThemes.mediumDarkTextStyle;

    return FractionallySizedBox(
      widthFactor: 0.7,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          optionText,
          style: textStyle,
        ),
        onPressed: () => {
          // Navigator.of(context).pushNamed(Routes.voteResult)
          votedCallback(index)
        },
        color: bg,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorThemes.lightYellowBackgroundColor,
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
                decoration: BoxDecoration(
                  color: ColorThemes.white,
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
                                  style: TextThemes.voteTagsTextStyle,
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
                            style: TextThemes.largeTitleTextStyle,
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
                            'PASS',
                            style: TextThemes.mediumDarkTextStyle,
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
  }
}
