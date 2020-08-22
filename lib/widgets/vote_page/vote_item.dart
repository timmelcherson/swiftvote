import 'package:flutter/material.dart';
import 'package:swiftvote/models/models.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';

class VoteItem extends StatelessWidget {
  final Vote vote;

  VoteItem({
    Key key,
    @required this.vote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 0.7,
                child: RaisedButton(
                  child: Text(
                    vote.voteOptions[0],
                    style: SwiftvoteTheme.darkQuestionTextStyle,
                  ),
                  onPressed: () => {print("pressed Messi")},
                  color: SwiftvoteTheme.primaryColor,
                  elevation: 6.0,
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: RaisedButton(
                  child: Text(
                    vote.voteOptions[1],
                    style: SwiftvoteTheme.lightQuestionTextStyle,
                  ),
                  onPressed: () => {print("pressed Ronaldo")},
                  color: Color.fromRGBO(242, 242, 242, 1),
                  elevation: 6.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}