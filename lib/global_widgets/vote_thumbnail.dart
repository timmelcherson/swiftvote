import 'package:flutter/material.dart';
import 'package:swiftvote/themes/decoration_themes.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteThumbnail extends StatelessWidget {
  final _thumbnailTitle;

  VoteThumbnail(this._thumbnailTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 16.0),
      width: MediaQuery.of(context).size.width / (2.5),
      height: 170.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [DecorationThemes.cardBoxShadow],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Text(
        _thumbnailTitle,
        style: TextThemes.thumbnailTitleTextStyle,
      ),
    );
  }
}
