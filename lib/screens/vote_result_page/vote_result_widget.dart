import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';
import 'dart:math';

class VoteResultWidget extends StatefulWidget {
  @override
  State createState() => _VoteResultWidgetState();
}

class _VoteResultWidgetState extends State<VoteResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Container(
        decoration: BoxDecoration(
          color: ColorThemes.white,
          boxShadow: [
            DecorationThemes.cardBoxShadow,
          ],
        ),
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: 350,
                width: 350,
                child: CustomPaint(
                  painter: CirclePainter(),
                ),
              ),
              Container(
                height: 350,
                width: 350,
                child: CustomPaint(
                  painter: ArcPainter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('SIZE OF CirclePainter: $size');
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
  @override
  void paint(Canvas canvas, Size size) {
    print('SIZE OF ArcPainter: $size');
    var paint1 = Paint()
      ..color = ColorThemes.silver
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2), height: size.height, width: size.width),
      0,
      2.14,
      true,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
