import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class RegisterGender extends StatefulWidget {
  @override
  State createState() => _RegisterGenderState();
}

class _RegisterGenderState extends State<RegisterGender> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 48.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Gender',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Male',
              style: TextThemes.mediumGrayTextStyle,
            ),
            Checkbox(value: _checked, onChanged: null),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Female',
              style: TextThemes.mediumGrayTextStyle,
            ),
            Checkbox(value: _checked, onChanged: null),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Other',
              style: TextThemes.mediumGrayTextStyle,
            ),
            Checkbox(value: _checked, onChanged: null),
          ],
        ),
      ],
    );
  }
}
