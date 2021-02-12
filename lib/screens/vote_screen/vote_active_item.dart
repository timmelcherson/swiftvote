import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/global_widgets/category_row.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class VoteActiveItem extends StatefulWidget {
  final Vote vote;

  VoteActiveItem({@required this.vote});

  @override
  _VoteActiveItemState createState() => _VoteActiveItemState();
}

class _VoteActiveItemState extends State<VoteActiveItem> {
  Vote _vote;

  @override
  void initState() {
    _vote = widget.vote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CategoryRow(categories: _vote.categories),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _vote.title,
                style: TextThemes.LARGE_WHITE,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      _vote.voteOptions[0],
                      style: TextThemes.SMALL_WHITE,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      _vote.voteOptions[1],
                      style: TextThemes.SMALL_WHITE,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'pass',
                      style: TextThemes.SMALL_WHITE,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Material(
                  color: ColorThemes.LIGHT_BLUE,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                  ),
                  child: InkWell(
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                    ),
                    onTap: () {
                      print('comments');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 12.0),
                      decoration: BoxDecoration(),
                      child: Icon(Icons.chat_bubble_outline_outlined),
                    ),
                  ),
                ),
                Material(
                  color: ColorThemes.LIGHT_YELLOW,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                  ),
                  child: InkWell(
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                    ),
                    onTap: () {
                      print('comments');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(24.0, 24.0, 12.0, 12.0),
                      decoration: BoxDecoration(),
                      child: Icon(Icons.flag_outlined),
                    ),
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
