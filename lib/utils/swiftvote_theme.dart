import 'package:flutter/material.dart';

class SwiftvoteTheme extends Theme {
  static const Color primaryColor = Color.fromRGBO(80, 92, 114, 1);
  static const Color primaryColorAccent = Color.fromRGBO(54, 46, 79, 1);
  static const Color secondaryColor = Color.fromRGBO(242, 242, 242, 1);
  static const Color secondaryColorAccent = Color.fromRGBO(50, 50, 50, 1);
  static const Color lightYellowBackgroundColor = Color.fromRGBO(255, 253, 245, 1);

  static const voteTagsTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 11.0,
    color: Color.fromRGBO(135, 135, 135, 1),
  );

  static const largeTitleTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 32.0,
    color: secondaryColorAccent,
  );

  static const TextStyle lightQuestionTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20.0,
    color: secondaryColorAccent,
  );

  static const TextStyle darkQuestionTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20.0,
    color: Color.fromRGBO(255, 255, 255, 1),
  );
}
