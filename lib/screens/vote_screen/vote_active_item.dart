import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/vote_comments/vote_comments.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/global_widgets/buttons/custom_outlined_button.dart';
import 'package:swiftvote/global_widgets/category_row.dart';
import 'package:swiftvote/themes/themes.dart';

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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CategoryRow(categories: _vote.categories),
          Expanded(
            flex: 2,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _vote.title,
                  style: bodyStyle(size: 14.0),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomOutlinedButton(
                    buttonText: _vote.voteOptions[0],
                    buttonTextStyle: buttonStyle(size: 14.0),
                    margin: EdgeInsets.all(0),
                    onPressFunction: () {},
                  ),
                  CustomOutlinedButton(
                    buttonText: _vote.voteOptions[1],
                    buttonTextStyle: buttonStyle(size: 14.0),
                    margin: EdgeInsets.all(0),
                    onPressFunction: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0, top: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Material(
                  color: LIGHT_BLUE,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                  ),
                  child: InkWell(
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                    ),
                    onTap: () {
                      BlocProvider.of<VoteCommentsBloc>(context).add(
                        LoadVoteCommentsByVoteIdEvent(vote: _vote),
                      );
                      Navigator.of(context).pushNamed(Routes.VOTE_COMMENTS);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 12.0),
                      decoration: BoxDecoration(),
                      child: Icon(Icons.chat_bubble_outline_outlined),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Pass', style: bodyStyle()),
                ),
                Material(
                  color: LIGHT_YELLOW,
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
