import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class VoteResultWidget extends StatefulWidget {
  @override
  State createState() => _VoteResultWidgetState();
}

class _VoteResultWidgetState extends State<VoteResultWidget> with SingleTickerProviderStateMixin {
  double _arcSecondRad = 0;
  AnimationController _animationController;
  Duration _arcAnimationDuration = Duration(milliseconds: 500);
  Animation<double> _arcAnimationPositive;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _arcAnimationDuration);

    _arcAnimationPositive = Tween(
      begin: _arcSecondRad,
      end: _arcSecondRad + 0.5,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _arcAnimationPositive.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // void _arcAnimation() {
  //   _animationController.drive(
  //     Tween<double>(
  //       begin: _arcSecondRad,
  //       end: _arcSecondRad += 0.2,
  //     ),
  //   );
  // }

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
                    painter: ArcPainter(0, _arcAnimationPositive.value),

                    // painter: ArcPainter(_animationController, _arcSecondRad),
                  ),
                ),
              ],
            ),
            FlatButton(
              color: Colors.blue[200],
              onPressed: () {
                setState(() {
                  _arcSecondRad += 0.1;
                });
              },
              child: Text('+'),
            ),
            FlatButton(
              color: Colors.red[300],
              onPressed: () {
                setState(() {
                  _arcSecondRad -= 0.1;
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
  // final AnimationController controller;
  // final Animation<double> animation;
  final double _startAngle;
  final double _endAngle;

  ArcPainter(this._startAngle, this._endAngle);

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
      _startAngle,
      _endAngle,
      true,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
