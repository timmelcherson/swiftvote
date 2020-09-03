import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/themes/themes.dart';

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
                    style: TextThemes.darkQuestionTextStyle,
                  ),
                  onPressed: () => {print("pressed Messi")},
                  color: ColorThemes.primaryColor,
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: RaisedButton(
                  child: Text(
                    vote.voteOptions[1],
                    style: TextThemes.lightQuestionTextStyle,
                  ),
                  onPressed: () => {print("pressed Ronaldo")},
                  color: Color.fromRGBO(242, 242, 242, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
