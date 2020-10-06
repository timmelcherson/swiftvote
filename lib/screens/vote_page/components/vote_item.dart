import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/routes.dart';

class VoteItem extends StatelessWidget {
  final Vote vote;

  VoteItem({
    Key key,
    @required this.vote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                vote.voteOptions[0],
                style: TextThemes.darkQuestionTextStyle,
              ),
              onPressed: () => {Navigator.of(context).pushNamed(Routes.voteResult)},
              color: ColorThemes.primaryColor,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                vote.voteOptions[1],
                style: TextThemes.lightQuestionTextStyle,
              ),
              onPressed: () => {Navigator.of(context).pushNamed(Routes.voteResult)},
              color: Color.fromRGBO(242, 242, 242, 1),
            ),
          ),
        ),
      ],
    );
  }
}
