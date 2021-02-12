import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/themes/text_themes.dart';

class VoteHistoryItem extends StatefulWidget {
  final Vote vote;

  VoteHistoryItem({@required this.vote});

  @override
  _VoteHistoryItemState createState() => _VoteHistoryItemState();
}

class _VoteHistoryItemState extends State<VoteHistoryItem> {
  Vote _vote;

  @override
  void initState() {
    _vote = widget.vote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.white,
          ),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _vote.title,
                  style: TextThemes.TINY_WHITE,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            _vote.voteOptions[0],
                            style: TextThemes.TINY_LIGHT_YELLOW,
                          ),
                        ),
                        Text('58%'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            _vote.voteOptions[1],
                            style: TextThemes.TINY_LIGHT_BLUE,
                          ),
                        ),
                        Text('42%'),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '3453 votes',
                  style: TextThemes.FOOTNOTE_SILVER,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
