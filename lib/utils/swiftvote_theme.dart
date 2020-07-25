import 'package:flutter/material.dart';

class SwiftvoteTheme extends Theme {
  static const Color primaryColor = Color.fromRGBO(80, 92, 114, 1);
  static const Color primaryColorAccent = Color.fromRGBO(107, 185, 240, 1);

  static const voteTagsTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 11.0,
    color: Color.fromRGBO(135, 135, 135, 1),
  );

  static const voteTitleTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 32.0,
    color: Color.fromRGBO(20, 20, 20, 1),
  );

  static const TextStyle lightQuestionTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20.0,
    color: Color.fromRGBO(0, 0, 0, 1),
  );

  static const TextStyle darkQuestionTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20.0,
    color: Color.fromRGBO(255, 255, 255, 1),
  );
}
