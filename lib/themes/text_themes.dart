

import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';

class TextThemes extends Theme {

  static const double FOOTNOTE = 11.0;
  static const double TINY = 14.0;
  static const double SMALL = 16.0;
  static const double MEDIUM = 18.0;
  static const double LARGE = 20.0;
  static const double LARGER = 22.0;
  static const double XLARGE = 24.0;
  static const double HUGE = 28.0;
  static const double TITLE = 32.0;


  // FOOTNOTE styles
  static const FOOTNOTE_CHARCOAL_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: FOOTNOTE,
    color: ColorThemes.CHARCOAL_GRAY,
  );

  // TINY size styles
  static const TextStyle TINY_CHARCOAL_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: TINY,
    color: ColorThemes.CHARCOAL_GRAY,
  );
  static const TextStyle TINY_DARK_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: TINY,
    color: ColorThemes.DARK_GRAY,
  );
  static const TextStyle TINY_WHITE = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: TINY,
    color: ColorThemes.WHITE,
  );
  static const TextStyle TINY_SILVER = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: TINY,
    color: ColorThemes.SILVER,
  );

  // SMALL size styles
  static const TextStyle SMALL_LIGHT_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: SMALL,
    color: ColorThemes.LIGHT_GRAY,
  );
  static const TextStyle SMALL_CHARCOAL_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: SMALL,
    color: ColorThemes.CHARCOAL_GRAY,
  );
  static const TextStyle SMALL_WHITE = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: SMALL,
    color: ColorThemes.WHITE,
  );
  static const TextStyle SMALL_SILVER = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: SMALL,
    color: ColorThemes.SILVER,
  );

  // MEDIUM size styles
  static const TextStyle MEDIUM_DARK_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: MEDIUM,
    color: ColorThemes.DARK_GRAY,
  );
  static const TextStyle MEDIUM_WHITE = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: MEDIUM,
    color: ColorThemes.WHITE,
  );
  static const TextStyle MEDIUM_CHARCOAL_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: MEDIUM,
    color: ColorThemes.CHARCOAL_GRAY,
  );

  // LARGE size styles
  static const TextStyle LARGE_LIGHT_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: LARGE,
    color: ColorThemes.LIGHT_GRAY,
  );

  // LARGER size styles
  static const TextStyle LARGER_DARK_GRAY_BOLD = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: LARGER,
    fontWeight: FontWeight.w300,
    color: ColorThemes.DARK_GRAY,
  );
  static const TextStyle LARGER_WHITE_BOLD = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: LARGER,
    fontWeight: FontWeight.w300,
    color: ColorThemes.WHITE,
  );
  static const TextStyle LARGER_CHARCOAL_GRAY_BOLD = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: LARGER,
    fontWeight: FontWeight.w300,
    color: ColorThemes.CHARCOAL_GRAY,
  );

  // XLARGE size styles
  static const XLARGE_GRANITE_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: XLARGE,
    color: ColorThemes.GRANITE_GRAY,
  );


  // HUGE size styles
  static const HUGE_GRANITE_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: HUGE,
    color: ColorThemes.GRANITE_GRAY,
  );
  static const HUGE_DIRTY_WHITE = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: HUGE,
    color: ColorThemes.DIRTY_WHITE,
  );

  // TITLE size styles
  static const TITLE_GRANITE_GRAY = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: TITLE,
    color: ColorThemes.GRANITE_GRAY,
  );

}