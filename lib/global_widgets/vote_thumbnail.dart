import 'package:flutter/material.dart';
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Text(
        _thumbnailTitle,
        style: bodyStyle(color: CHARCOAL_GRAY),
      ),
    );
  }
}
