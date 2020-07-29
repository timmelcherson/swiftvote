import 'package:flutter/material.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';
import 'package:swiftvote/widgets/vote_page/vote_item.dart';

class VoteWidget extends StatelessWidget {

  VoteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
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
              ),
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(125, 125, 125, 1))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Sports',
                                style: SwiftvoteTheme.voteTagsTextStyle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Football',
                              style: SwiftvoteTheme.voteTagsTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // Related tags
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Who is better',
                            style: SwiftvoteTheme.voteTitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ), // Vote Title
                  VoteItem(
                    vote: vote,
                    onTap: () async {
                      print('Vote was tapped');
                    },
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text('Pass'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('+'),
          )
        ],
      ),
    );
  }
}
