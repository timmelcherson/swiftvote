import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/themes/themes.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.white,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            _vote.title,
            style: footnoteStyle(),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      _vote.voteOptions[0],
                      style: footnoteStyle(color: LIGHT_YELLOW),
                    ),
                  ),
                  Text('58%', style: footnoteStyle()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      _vote.voteOptions[1],
                      style: footnoteStyle(color: LIGHT_BLUE),
                    ),
                  ),
                  Text('42%', style: footnoteStyle()),
                ],
              ),
            ],
          ),
          Text('3453 votes', style: footnoteStyle(color: SILVER)),
        ],
      ),
    );
  }
}
