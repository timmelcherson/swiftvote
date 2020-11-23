

import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class RegisterOptionalInterests extends StatefulWidget {


  @override
  State createState() => _RegisterOptionalInterestsState();
}

class _RegisterOptionalInterestsState extends State<RegisterOptionalInterests> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 48.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Interests',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}