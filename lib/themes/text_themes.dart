

import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';

class TextThemes extends Theme {

  static const voteTagsTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 11.0,
    color: Color.fromRGBO(135, 135, 135, 1),
  );

  static const largeTitleTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 32.0,
    color: ColorThemes.secondaryColorAccent,
  );

  static const mediumTitleTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 28.0,
    color: ColorThemes.secondaryColorAccent,
  );

  static const TextStyle lightQuestionTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20.0,
    color: ColorThemes.secondaryColorAccent,
  );

  static const TextStyle darkQuestionTextStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20.0,
    color: Color.fromRGBO(255, 255, 255, 1),
  );

  static const TextStyle textHintStyle = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 20.0,
    color: Color.fromRGBO(170, 170, 170, 1),
  );
}