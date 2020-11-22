import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class RegisterOptionalGender extends StatefulWidget {
  @override
  State createState() => _RegisterOptionalGenderState();
}

class _RegisterOptionalGenderState extends State<RegisterOptionalGender> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Gender',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          ),
        ),
      ],
    );
  }
}
