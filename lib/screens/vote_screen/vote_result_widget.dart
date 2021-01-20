import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteResultWidget extends StatefulWidget {
  final Vote vote;

  VoteResultWidget({@required this.vote});

  @override
  State createState() => _VoteResultWidgetState();
}

class _VoteResultWidgetState extends State<VoteResultWidget> {
  Vote _vote;
  double startAngle = 3 / 2 * pi;
  double endAngle;
  String firstPercentage;
  String secondPercentage;
  bool _showDetails = false;
  VoteResultBloc _voteResultBloc;


  @override
  void initState() {
    super.initState();
    _vote = widget.vote;
    _voteResultBloc = BlocProvider.of(context);
    print('INITIALIZING RESULTS WITH VOTE SCORES: ');
    // print(_vote.votes);
    _voteResultBloc.add(VoteResultRequestedEvent(voteId: _vote.id));
    // double firstOptionPercentage =
    //     _vote.votes[0] / (_vote.votes[0] + _vote.votes[1]);
    // double secondOptionPercentage =
    //     _vote.votes[1] / (_vote.votes[0] + _vote.votes[1]);
    double firstOptionPercentage = 0.4;
    double secondOptionPercentage = 0.6;
    firstPercentage = (firstOptionPercentage * 100).floor().toString();
    secondPercentage = (secondOptionPercentage * 100).floor().toString();

    endAngle = 2 * pi * secondOptionPercentage;
    print('startangle: $startAngle, calculated endangle: $endAngle');
    print('angle difference: ${endAngle - startAngle}');
    print(secondOptionPercentage);
  }

  @override
  Widget build(BuildContext context) {
    double halfAngle = endAngle / 2;

    print(startAngle);
    print(endAngle);
    print(halfAngle);

    print((cos(halfAngle) * 150));
    return BlocBuilder<VoteResultBloc, VoteResultState>(
      builder: (context, state) {
        if (state is VoteResultInitialState) {
          return LoadingIndicator();
        }
        if (state is VoteResultLoadedState) {
          print(state.voteResults);
          return Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Container(
              decoration: BoxDecoration(
                color: ColorThemes.WHITE,
                boxShadow: [
                  DecorationThemes.cardBoxShadow,
                ],
              ),
              child: SingleChildScrollView(
                physics:
                _showDetails ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
                child: IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 0, 0, 24.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  _vote.title,
                                  style: TextThemes.SMALL_LIGHT_GRAY,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Next vote',
                                    style: TextThemes.SMALL_DARK_GRAY,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 300.0,
                              height: 300.0,
                              child: CustomPaint(
                                painter: CirclePainter(),
                              ),
                            ),
                            SizedBox(
                              width: 300.0,
                              height: 300.0,
                              child: CustomPaint(
                                painter: ArcPainter(startAngle, endAngle),
                                // painter: ArcPainter(_animationController, _arcSecondRad),
                              ),
                            ),
                            Positioned(
                              width: 50.0,
                              height: 50.0,
                              top: 125.0 + (cos(halfAngle) * 150) * 0.7,
                              left: 125.0 - (sin(halfAngle) * 150) * 0.7,
                              child: Center(
                                child: Text(
                                  firstPercentage + '%',
                                  textAlign: TextAlign.center,
                                  style: TextThemes.LARGER_WHITE_BOLD,
                                ),
                              ),
                            ),
                            Positioned(
                              width: 50.0,
                              height: 50.0,
                              top: 125.0 - (cos(halfAngle) * 150) * 0.7,
                              left: 125.0 + (sin(halfAngle) * 150) * 0.7,
                              child: Center(
                                child: Text(
                                  secondPercentage + '%',
                                  textAlign: TextAlign.center,
                                  style: TextThemes.LARGER_DARK_GRAY_BOLD,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 24.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12.0),
                                height: 12.0,
                                width: 6.0,
                                color: ColorThemes.PRIMARY_BLUE,
                              ),
                              Expanded(
                                child: Text(
                                  _vote.voteOptions[0],
                                  style: TextThemes.MEDIUM_DARK_GRAY,
                                ),
                              ),
                              Text(
                                '$firstPercentage %',
                                style: TextThemes.MEDIUM_DARK_GRAY,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12.0),
                                height: 12.0,
                                width: 6.0,
                                color: ColorThemes.SILVER,
                              ),
                              Expanded(
                                child: Text(
                                  _vote.voteOptions[1],
                                  style: TextThemes.MEDIUM_DARK_GRAY,
                                ),
                              ),
                              Text(
                                '$secondPercentage %',
                                style: TextThemes.MEDIUM_DARK_GRAY,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                _showDetails = !_showDetails;
                              });
                            },
                            color: ColorThemes.SILVER,
                            child: Text(
                              'Details',
                              style: TextThemes.FOOTNOTE_CHARCOAL_GRAY,
                            ),
                          ),
                        ),
                        if (_showDetails)
                          Column(
                            children: [
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                              Text('11111'),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        if (state is VoteResultLoadFailState) {
          return Container();
        }

        return LoadingIndicator();
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = ColorThemes.PRIMARY_BLUE
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(size.height / 2, size.width / 2), size.width / 2, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ArcPainter extends CustomPainter {
  final double _startAngle;
  final double _endAngle;

  ArcPainter(this._startAngle, this._endAngle);

  @override
  void paint(Canvas canvas, Size size) {
    var arcFillPaint = Paint()
      ..color = ColorThemes.SILVER
      ..style = PaintingStyle.fill;

    var arcStrokePaint = Paint()
      ..color = ColorThemes.WHITE
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2), height: size.height, width: size.width),
      _startAngle,
      _endAngle,
      true,
      arcStrokePaint,
    );

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2), height: size.height, width: size.width),
      _startAngle,
      _endAngle,
      true,
      arcFillPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
