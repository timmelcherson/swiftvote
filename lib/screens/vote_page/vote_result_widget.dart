import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
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

  @override
  void initState() {
    super.initState();
    _vote = widget.vote;

    print('INITIALIZING RESULTS WITH VOTE SCORES: ');
    print(_vote.votes);

    double firstOptionPercentage = _vote.votes[0] / (_vote.votes[0] + _vote.votes[1]);
    double secondOptionPercentage = _vote.votes[1] / (_vote.votes[0] + _vote.votes[1]);
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
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Container(
        decoration: BoxDecoration(
          color: ColorThemes.WHITE,
          boxShadow: [
            DecorationThemes.cardBoxShadow,
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              // color: Colors.red.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0),
                child: Stack(
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
              ),
            ),
            FlatButton(
              color: Colors.blue[200],
              onPressed: () {
                setState(() {
                  endAngle += 0.1;
                });
              },
              child: Text('+'),
            ),
            FlatButton(
              color: Colors.red[300],
              onPressed: () {
                setState(() {
                  endAngle -= 0.1;
                });
              },
              child: Text('--'),
            ),
          ],
        ),
      ),
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
