import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteResultScreen extends StatefulWidget {
  @override
  State createState() => _VoteResultScreenState();
}

class _VoteResultScreenState extends State<VoteResultScreen> {
  Vote _vote;
  double _startAngleTop = -(pi / 2);
  double _startAngleBottom = pi / 2;
  double _sweepAngleOptionOne;
  double _sweepAngleOptionTwo;
  double _optionOnePart;
  double _optionTwoPart;
  int _totalVotes;

  bool _femaleFilterActive = false;
  bool _maleFilterActive = false;

  bool _showDetails = false;
  VoteResultBloc _voteResultBloc;
  String _selectedAgeFilter;
  final List<String> _ages = ['18-30', '30-50', '50+'];

  @override
  void initState() {
    super.initState();
    _voteResultBloc = BlocProvider.of<VoteResultBloc>(context);
    if (_voteResultBloc.state is VoteResultLoadedState) {
      setVoteResultStandard();
    }
    _voteResultBloc.stream.listen((state) {
      if (state is VoteResultLoadedState) {
        setVoteResultStandard();
      }
    });
  }

  void setVoteResultStandard() {
    setState(() {
      _vote = (_voteResultBloc.state as VoteResultLoadedState).vote;
      _totalVotes = (_voteResultBloc.state as VoteResultLoadedState).voteResults.length;
      _optionOnePart = (_voteResultBloc.state as VoteResultLoadedState).getOptionOnePart;
      _optionTwoPart = (_voteResultBloc.state as VoteResultLoadedState).getOptionTwoPart;
      _sweepAngleOptionOne = 2 * pi * _optionOnePart;
      _sweepAngleOptionTwo = 2 * pi * _optionTwoPart;
      _femaleFilterActive = false;
      _maleFilterActive = false;
    });
    print('_optionOnePart: $_optionOnePart');
    print('_optionTwoPart: $_optionTwoPart');
  }

  void filterFemale() {
    if (!_femaleFilterActive) {
      print('filterFemale');
      setState(() {
        _totalVotes = (_voteResultBloc.state as VoteResultLoadedState).getFemaleTotalVotes;
        _optionOnePart = (_voteResultBloc.state as VoteResultLoadedState).getFemaleOptionOnePart;
        _optionTwoPart = (_voteResultBloc.state as VoteResultLoadedState).getFemaleOptionTwoPart;
        _sweepAngleOptionOne = 2 * pi * _optionOnePart;
        _sweepAngleOptionTwo = 2 * pi * _optionTwoPart;
        _femaleFilterActive = true;
        _maleFilterActive = false;
      });
      print('_optionOnePart: $_optionOnePart');
      print('_optionTwoPart: $_optionTwoPart');
    } else {
      setVoteResultStandard();
    }
  }

  void filterMale() {
    if (!_maleFilterActive) {
      print('filterMale');
      setState(() {
        _totalVotes = (_voteResultBloc.state as VoteResultLoadedState).getMaleTotalVotes;
        _optionOnePart = (_voteResultBloc.state as VoteResultLoadedState).getMaleOptionOnePart;
        _optionTwoPart = (_voteResultBloc.state as VoteResultLoadedState).getMaleOptionTwoPart;
        _sweepAngleOptionOne = 2 * pi * _optionOnePart;
        _sweepAngleOptionTwo = 2 * pi * _optionTwoPart;
        _maleFilterActive = true;
        _femaleFilterActive = false;
      });
      print('_optionOnePart: $_optionOnePart');
      print('_optionTwoPart: $_optionTwoPart');
    } else {
      setVoteResultStandard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _voteResultBloc,
        builder: (context, state) {
          // if (state is VoteResultInitialState || _vote == null) {
          //   return LoadingIndicator();
          // }
          if (state is VoteResultLoadedState) {
            // print(state.voteResults);
            return Container(
              padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CategoryRow(categories: state.vote.categories),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(8.0, 0, 0, 24.0),
                    child: Text(
                      state.vote.title,
                      style: bodyStyle(),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      // SizedBox(
                      //   width: 200.0,
                      //   height: 200.0,
                      //   child: CustomPaint(
                      //     painter: CirclePainter(
                      //       fillColor: Color.fromARGB(255, 151, 174, 255),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 200.0,
                        height: 200.0,
                        child: CustomPaint(
                          painter: ArcPainter(
                            startAngle: _startAngleTop,
                            sweepAngle: _sweepAngleOptionTwo,
                          ),
                          // painter: ArcPainter(_animationController, _arcSecondRad),
                        ),
                      ),
                      SizedBox(
                        width: 200.0,
                        height: 200.0,
                        child: CustomPaint(
                          painter: ArcPainter(
                            startAngle: _startAngleTop + _sweepAngleOptionTwo,
                            sweepAngle: _sweepAngleOptionOne,
                            color: LIGHT_YELLOW,
                          ),
                          // painter: ArcPainter(_animationController, _arcSecondRad),
                        ),
                      ),
                      SizedBox(
                        width: 140.0,
                        height: 140.0,
                        child: CustomPaint(
                          painter: CirclePainter(
                            fillColor: PRIMARY_BG,
                          ),
                          // painter: ArcPainter(_animationController, _arcSecondRad),
                        ),
                      ),
                      SizedBox(
                        width: 125.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${(_optionOnePart * 100).floor()}%', style: bodyStyle()),
                            Text('${100 - (_optionOnePart * 100).floor()}%', style: bodyStyle()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 12.0,
                              width: 12.0,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                color: LIGHT_YELLOW,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            Text(
                              '${state.vote.voteOptions[0]}',
                              style: bodyStyle(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 12.0,
                              width: 12.0,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                color: SKY_BLUE,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            Text(
                              '${state.vote.voteOptions[1]}',
                              style: bodyStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$_totalVotes votes',
                        style: bodyStyle(),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          buttonText: 'Female',
                          backgroundColor: _femaleFilterActive ? Colors.greenAccent[200] : OFF_WHITE,
                          onPress: filterFemale,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          buttonText: 'Male',
                          backgroundColor: _maleFilterActive ? Colors.greenAccent[200] : OFF_WHITE,
                          onPress: filterMale,
                        ),
                      ),
                    ],
                  )

                  // Row(
                  //   children: [
                  //     DropdownButton(
                  //       value: _selectedAgeFilter,
                  //         items: List.generate(_ages.length, (index) {
                  //           return DropdownMenuItem(child: Text(_ages[index]));
                  //         })
                  //         onChanged: (value) {
                  //           print('$value selected');
                  //         }),
                  //   ],
                  // ),
                  // if (_showDetails)
                  //   Column(
                  //     children: [
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //       Text('11111'),
                  //     ],
                  //   ),
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
    _voteResultBloc?.close();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final Color fillColor;

  CirclePainter({this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(size.height / 2, size.width / 2), size.width / 2, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final Color color;

  ArcPainter({@required this.startAngle, @required this.sweepAngle, this.color = SKY_BLUE});

  @override
  void paint(Canvas canvas, Size size) {
    var arcFillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // var arcStrokePaint = Paint()
    //   ..color = ColorThemes.WHITE
    //   ..strokeWidth = 5.0
    //   ..style = PaintingStyle.stroke;

    // canvas.drawArc(
    //   Rect.fromCenter(
    //       center: Offset(size.width / 2, size.height / 2), height: size.height, width: size.width),
    //   _startAngle,
    //   _endAngle,
    //   true,
    //   arcStrokePaint,
    // );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: size.height,
        width: size.width,
      ),
      startAngle,
      sweepAngle,
      true,
      arcFillPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
