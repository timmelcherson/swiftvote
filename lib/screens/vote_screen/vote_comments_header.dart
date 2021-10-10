import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/themes/text_themes.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteCommentsHeader extends StatelessWidget {
  final Vote vote;

  VoteCommentsHeader({@required this.vote});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(color: Colors.white, width: 1.0),
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white54, width: 1.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comments',
                      style: bodyStyle(),
                    ),
                    Text(
                      '180 000',
                      style: bodyStyle(),
                    ),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Text(
              vote.title,
              style: bodyStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    vote.voteOptions[0],
                    style: bodyStyle(color: LIGHT_BLUE, size: 14.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 32.0),
                        width: 61.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: LIGHT_BLUE,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text('61%', style: footnoteStyle(color: LIGHT_BLUE)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    vote.voteOptions[1],
                    style: bodyStyle(color: LIGHT_YELLOW, size: 14.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 32.0),
                        width: 39.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: LIGHT_YELLOW,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text('39%', style: footnoteStyle(color: LIGHT_YELLOW)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
