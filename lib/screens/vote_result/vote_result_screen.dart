import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/vote_result/result_filter.dart';
import 'package:swiftvote/screens/vote_result/vote_comments_list.dart';
import 'package:swiftvote/screens/vote_screen/vote_list_result_bars.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteResultScreen extends StatefulWidget {
  @override
  State createState() => _VoteResultScreenState();
}

class _VoteResultScreenState extends State<VoteResultScreen> {
  late Vote _vote;
  double _startAngleTop = -(pi / 2);
  double _startAngleBottom = pi / 2;
  late double _sweepAngleOptionOne;
  late double _sweepAngleOptionTwo;
  late double _optionOnePart;
  late double _optionTwoPart;
  late int _totalVotes;

  bool _femaleFilterActive = false;
  bool _maleFilterActive = false;

  bool _showDetails = false;
  late VoteResultBloc _voteResultBloc;
  late String _selectedAgeFilter;
  final List<String> _ages = ['18-30', '30-50', '50+'];

  @override
  void initState() {
    super.initState();
    // _voteResultBloc = BlocProvider.of<VoteResultBloc>(context);
    // if (_voteResultBloc.state is VoteResultLoadedState) {
    //   setVoteResultStandard();
    // }
    // _voteResultBloc.stream.listen((state) {
    //   if (state is VoteResultLoadedState) {
    //     setVoteResultStandard();
    //   }
    // });
  }

  // void setVoteResultStandard() {
  //   setState(() {
  //     // _vote = (_voteResultBloc.state as VoteResultLoadedState).vote;
  //     // _totalVotes = (_voteResultBloc.state as VoteResultLoadedState).voteResults.length;
  //     // _optionOnePart = (_voteResultBloc.state as VoteResultLoadedState).getOptionOnePart;
  //     // _optionTwoPart = (_voteResultBloc.state as VoteResultLoadedState).getOptionTwoPart;
  //     _sweepAngleOptionOne = 2 * pi * _optionOnePart;
  //     _sweepAngleOptionTwo = 2 * pi * _optionTwoPart;
  //     _femaleFilterActive = false;
  //     _maleFilterActive = false;
  //   });
  //   print('_optionOnePart: $_optionOnePart');
  //   print('_optionTwoPart: $_optionTwoPart');
  // }
  //
  // void filterFemale() {
  //   if (!_femaleFilterActive) {
  //     print('filterFemale');
  //     setState(() {
  //       // _totalVotes = (_voteResultBloc.state as VoteResultLoadedState).getFemaleTotalVotes;
  //       // _optionOnePart = (_voteResultBloc.state as VoteResultLoadedState).getFemaleOptionOnePart;
  //       // _optionTwoPart = (_voteResultBloc.state as VoteResultLoadedState).getFemaleOptionTwoPart;
  //       _sweepAngleOptionOne = 2 * pi * _optionOnePart;
  //       _sweepAngleOptionTwo = 2 * pi * _optionTwoPart;
  //       _femaleFilterActive = true;
  //       _maleFilterActive = false;
  //     });
  //     print('_optionOnePart: $_optionOnePart');
  //     print('_optionTwoPart: $_optionTwoPart');
  //   } else {
  //     setVoteResultStandard();
  //   }
  // }
  //
  // void filterMale() {
  //   if (!_maleFilterActive) {
  //     print('filterMale');
  //     setState(() {
  //       // _totalVotes = (_voteResultBloc.state as VoteResultLoadedState).getMaleTotalVotes;
  //       // _optionOnePart = (_voteResultBloc.state as VoteResultLoadedState).getMaleOptionOnePart;
  //       // _optionTwoPart = (_voteResultBloc.state as VoteResultLoadedState).getMaleOptionTwoPart;
  //       _sweepAngleOptionOne = 2 * pi * _optionOnePart;
  //       _sweepAngleOptionTwo = 2 * pi * _optionTwoPart;
  //       _maleFilterActive = true;
  //       _femaleFilterActive = false;
  //     });
  //     print('_optionOnePart: $_optionOnePart');
  //     print('_optionTwoPart: $_optionTwoPart');
  //   } else {
  //     setVoteResultStandard();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SECONDARY_BG,
      ),
      backgroundColor: SECONDARY_BG,
      body: BlocBuilder<VoteResultBloc, VoteResultState>(
        builder: (context, state) {
          // if (state is VoteResultInitialState || _vote == null) {
          //   return LoadingIndicator();
          // }
          if (state is VoteResultReadyState) {
            // print(state.voteResults);
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0),
              margin: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 24.0),
                          child: Text(
                            state.vote.title,
                            style: smallTitleStyle(),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        VoteListResultBars(
                          vote: state.vote,
                          firstBarLength: 0.6,
                          secondBarLength: 0.4,
                        ),
                        Text('${state.vote.totalVotes} Votes'),
                        ResultFilter(),
                      ],
                    ),
                  ),
                  VoteCommentsList(),
                ],
              ),
            );
          }

          if (state is VoteResultLoadFailState) {
            return Center(
              child: Text('Could not load vote results'),
            );
          }

          return LoadingIndicator();
        },
      ),
    );
  }

  @override
  void dispose() {
    _voteResultBloc.close();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final Color fillColor;

  CirclePainter({required this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(
        Offset(size.height / 2, size.width / 2), size.width / 2, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
