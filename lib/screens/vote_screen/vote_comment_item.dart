import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class VoteCommentItem extends StatelessWidget {
  final String content;
  final int commentIndex;
  final String createdAt;

  VoteCommentItem({this.content, this.commentIndex, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                height: 24,
                width: 24,
                margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: Text(
                  (commentIndex + 1).toString(),
                  style: bodyStyle(color: PRIMARY_BG, size: 14.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(createdAt, style: footnoteStyle(color: CHARCOAL_GRAY)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 8.0, 16.0, 0),
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
