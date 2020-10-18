import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteResultWidget extends StatefulWidget {
  @override
  State createState() => _VoteResultWidgetState();
}

class _VoteResultWidgetState extends State<VoteResultWidget> {
  double startAngle = 3 / 2 * pi;
  double endAngle = 1 / 2 * pi;

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
          color: ColorThemes.white,
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
                          '50%',
                          textAlign: TextAlign.center,
                          style: TextThemes.largeBrightTextStyle,
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
                          '50%',
                          textAlign: TextAlign.center,
                          style: TextThemes.largeDarkTextStyle,
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
      ..color = ColorThemes.primaryColor
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
      ..color = ColorThemes.silver
      ..style = PaintingStyle.fill;

    var arcStrokePaint = Paint()
      ..color = ColorThemes.white
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
