import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteResultWidget extends StatefulWidget {


  final Duration arcAnimationDuration = Duration(milliseconds: 500);

  @override
  State createState() => _VoteResultWidgetState();
}

class _VoteResultWidgetState extends State<VoteResultWidget> with SingleTickerProviderStateMixin {
  double _startAngle = pi / 2;
  double endAngle = pi / 2;

  AnimationController _animationController;
  Animation<double> _arcAnimationPositive;
  Animation<double> _arcAnimation;

  @override
  void initState() {
    print('init state');
    _animationController = AnimationController(vsync: this, duration: widget.arcAnimationDuration);

    // _arcAnimationPositive = Tween(
    //   begin: _startAngle,
    //   end: endAngle + 0.5,
    // ).animate(_animationController)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    // _animationController.addStatusListener((state) {
    //   if (state == AnimationStatus.completed) {
    //     print('animationstatus completed');
    //     _animationController.forward();
    //   }
    //   setState(() {
    //     print('_arcAnimation.value');
    //   });
    // });
    //
    // _animationController.forward();

    _animationController.addListener(() {
      setState(() {
        print(_arcAnimation.value);
        endAngle = _arcAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _runArcAnimation(double diff) {
    _arcAnimation = _animationController.drive(
      Tween<double>(
        begin: _startAngle,
        end: endAngle += diff,
      ),
    );

    _animationController.animateTo(endAngle, curve: Curves.easeOut);
  }

  void adjustAngle(double diff) {
    setState(() {
      endAngle += diff;
    });
  }

  @override
  Widget build(BuildContext context) {

    print('build');
    print(endAngle);
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
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: CustomPaint(
                    painter: CirclePainter(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: CustomPaint(
                    painter: ArcPainter(_startAngle, endAngle),

                    // painter: ArcPainter(_animationController, _arcSecondRad),
                  ),
                ),
              ],
            ),
            FlatButton(
              color: Colors.blue[200],
              onPressed: () {
                _runArcAnimation(0.2);
              },
              child: Text('+'),
            ),
            FlatButton(
              color: Colors.red[300],
              onPressed: () {
                _runArcAnimation(-0.2);
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
  // final AnimationController controller;
  // final Animation<double> animation;
  final double _startAngle;
  final double _endAngle;

  ArcPainter(this._startAngle, this._endAngle);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = ColorThemes.silver
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2), height: size.height, width: size.width),
      _startAngle,
      _endAngle,
      true,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
