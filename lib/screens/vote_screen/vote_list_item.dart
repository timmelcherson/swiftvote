import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/blocs/user_profile/user_profile.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/global_widgets/buttons/custom_outlined_button.dart';
import 'package:swiftvote/global_widgets/category_row.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteListItem extends StatefulWidget {
  final Vote vote;

  const VoteListItem({
    Key key,
    this.vote,
  }) : super(key: key);

  @override
  _VoteListItemState createState() => _VoteListItemState();
}

class _VoteListItemState extends State<VoteListItem> {
  bool _expanded = false;
  bool _voted = false;
  int _votedIndex;
  double _barWidth1 = 0.0;
  double _barWidth2 = 0.0;

  void handleVoteOptionTap(int index) {
    setState(() {
      _voted = !_voted;
      _barWidth1 = _voted ? 0.66 : 0;
      _barWidth2 = _voted ? 0.34 : 0;
      _votedIndex = index;
    });
    print('votedIndex: $_votedIndex');
    // if (BlocProvider.of<UserProfileBloc>(context).state is UserProfileReadyState) {
    //   print('goes in here');
    //   UserProfile userProfile =
    //       (BlocProvider.of<UserProfileBloc>(context).state as UserProfileReadyState).userProfile;
    //   print(BlocProvider.of<VoteResultBloc>(context));
    //   BlocProvider.of<VoteResultBloc>(context)
    //     ..add(AddVoteResultEvent(voteId: widget.vote.id, votedIndex: index, voter: userProfile))
    //     ..add(LoadVoteResultByVoteIdEvent(vote: widget.vote));
    //
    //   Navigator.of(context).pushNamed(Routes.VOTE_RESULT);
    // }
  }

  Widget _voteWidget() {
    return Column(
      children: [
        CustomOutlinedButton(
          buttonText: widget.vote.voteOptions[0],
          buttonTextStyle: buttonStyle(size: 14.0),
          height: 48.0,
          margin: EdgeInsets.symmetric(vertical: 4.0),
          onPress: () => handleVoteOptionTap(0),
        ),
        CustomOutlinedButton(
          buttonText: widget.vote.voteOptions[1],
          buttonTextStyle: buttonStyle(size: 14.0),
          height: 48.0,
          margin: EdgeInsets.symmetric(vertical: 4.0),
          onPress: () => handleVoteOptionTap(1),
        ),
      ],
    );
  }

  Widget _resultWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            widget.vote.voteOptions[0],
            style: footnoteStyle(),
          ),
        ),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 24.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0)
              )
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutQuad,
                  height: 24.0,
                  width: MediaQuery.of(context).size.width * 0.8 * _barWidth1,
                  margin: const EdgeInsets.only(right: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Text('66%', style: footnoteStyle()),
                if (_votedIndex == 0) Icon(Icons.check, size: 20.0, color: DARK_GRAY)
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            widget.vote.voteOptions[1],
            style: footnoteStyle(),
          ),
        ),
        Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutQuad,
              height: 24.0,
              width: MediaQuery.of(context).size.width * 0.8 * _barWidth2,
              margin: const EdgeInsets.only(right: 16.0),
              decoration: BoxDecoration(
                color: PRIMARY_YELLOW,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Text('34%', style: footnoteStyle()),
            if (_votedIndex == 1) Icon(Icons.check, size: 20.0, color: DARK_GRAY)
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('2021-07-18', style: footnoteStyle()),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ],
              ),
              CategoryRow(categories: widget.vote.categories),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 24.0),
                child: Text(widget.vote.title, style: bodyStyle(), textAlign: TextAlign.left,),
              ),
              AnimatedCrossFade(
                firstChild: _voteWidget(),
                secondChild: _resultWidget(),
                crossFadeState: _voted ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
