import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class VoteCommentItem extends StatelessWidget {
  final String content;
  final int commentIndex;
  final DateTime createdAt;

  VoteCommentItem({this.content, this.commentIndex, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white38)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 20,
                width: 20,
                margin: const EdgeInsets.only(right: 8.0),
                child: Text(
                  (commentIndex + 1).toString(),
                  style: bodyStyle(color: DEEP_BLUE_BG, size: 14.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                createdAt.toString(),
                style: footnoteStyle(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              content,
              style: bodyStyle(size: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
