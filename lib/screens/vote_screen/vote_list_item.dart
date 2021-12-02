import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/blocs/user_profile/index.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/global_widgets/buttons/custom_outlined_button.dart';
import 'package:swiftvote/global_widgets/category_row.dart';
import 'package:swiftvote/themes/themes.dart';

import 'vote_list_result_bars.dart';

class VoteListItem extends StatefulWidget {
  final Vote vote;

  const VoteListItem({
    required Key key,
    required this.vote,
  }) : super(key: key);

  @override
  _VoteListItemState createState() => _VoteListItemState();
}

class _VoteListItemState extends State<VoteListItem> {
  late Vote _vote;
  bool _voted = false;
  int? _votedIndex;

  @override
  void initState() {
    super.initState();
    _vote = widget.vote;
  }

  void handleVoteOptionTap(int index) {
    setState(() {
      _voted = !_voted;
      _votedIndex = index;
    });
    BlocProvider.of<VoteResultBloc>(context).add(VoteResultVotedEvent(vote: _vote));
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
          margin: EdgeInsets.symmetric(vertical: 8.0),
          onPress: () => handleVoteOptionTap(0),
        ),
        CustomOutlinedButton(
          buttonText: widget.vote.voteOptions[1],
          buttonTextStyle: buttonStyle(size: 14.0),
          height: 48.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          onPress: () => handleVoteOptionTap(1),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2021-07-18', style: footnoteStyle()),
              Icon(Icons.more_horiz, color: Colors.white, size: 20.0),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              widget.vote.title,
              style: bodyStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          AnimatedCrossFade(
            firstChild: _voteWidget(),
            secondChild: VoteListResultBars(vote: _vote, firstBarLength: 0.6, secondBarLength: 0.4,),
            crossFadeState:
                _voted ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
          ),
          AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: 300),
            child: Container(
              color: Colors.red,
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: GestureDetector(
                onTap: _voted ? () => Navigator.of(context).pushNamed(Routes.VOTE_RESULT) : null,
                child: Text(
                  'Details',
                  style: bodyStyle(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}