
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class WelcomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            'Welcome to Swiftvote',
            style: TextThemes.largeTitleTextStyle,
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Log in',
              style: TextThemes.smallBrightTextStyle,
            ),
            onPressed: () => {print('LOG IN')},
            color: ColorThemes.primaryColor,
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            margin: EdgeInsets.only(top: 12.0),
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Create an account',
                style: TextThemes.smallDarkTextStyle,
              ),
              onPressed: () => {print('SIGN UP')},
              color: ColorThemes.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}