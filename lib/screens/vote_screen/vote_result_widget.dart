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
  String _selectedAgeFilter;
  final List<String> _ages = ['18-30', '30-50', '50+'];

  @override
  void initState() {
    super.initState();
    _vote = widget.vote;
    _voteResultBloc = BlocProvider.of(context);
    print('INITIALIZING RESULTS WITH VOTE SCORES: ');
    // print(_vote.votes);
    // _voteResultBloc.add(VoteResultRequestedEvent(voteId: _vote.id));
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

    print(_vote);
    return BlocBuilder<VoteResultBloc, VoteResultState>(
      builder: (context, state) {
        // if (state is VoteResultInitialState || _vote == null) {
        //   return LoadingIndicator();
        // }
        if (_vote != null) {
          // print(state.voteResults);
          return Container(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CategoryRow(categories: _vote.categories),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 24.0),
                  child: Text(
                    _vote.title,
                    style: bodyStyle(),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: CustomPaint(
                        painter: CirclePainter(
                          fillColor: Color.fromARGB(255, 151, 174, 255),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: CustomPaint(
                        painter: ArcPainter(startAngle, endAngle),
                        // painter: ArcPainter(_animationController, _arcSecondRad),
                      ),
                    ),
                    SizedBox(
                      width: 140.0,
                      height: 140.0,
                      child: CustomPaint(
                        painter: CirclePainter(
                          fillColor: DEEP_BLUE_BG,
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
                          Text(
                            '$firstPercentage%',
                            style: bodyStyle(),
                          ),
                          Text(
                            '$secondPercentage%',
                            style: bodyStyle(),
                          ),
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
                              color: Color.fromARGB(255, 151, 174, 255),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          Text(
                            '${_vote.voteOptions[0]}',
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
                              color: Color.fromARGB(255, 249, 213, 117),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          Text(
                            '${_vote.voteOptions[1]}',
                            style: bodyStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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

        // if (state is VoteResultLoadFailState) {
        //   return Container();
        // }

        return LoadingIndicator();
      },
    );
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
  final double _startAngle;
  final double _endAngle;

  ArcPainter(this._startAngle, this._endAngle);

  @override
  void paint(Canvas canvas, Size size) {
    var arcFillPaint = Paint()
      ..color = Color.fromARGB(255, 249, 213, 117)
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
