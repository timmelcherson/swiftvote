import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';

const FontWeight LIGHT = FontWeight.w300;
const FontWeight NORMAL = FontWeight.w400;
const FontWeight MEDIUM = FontWeight.w500;
const FontWeight BOLD = FontWeight.w600;
const FontWeight EXTRA_BOLD = FontWeight.w700;

// static const double FOOTNOTE = 11.0;
// static const double TINY = 14.0;
// static const double SMALL = 16.0;
// static const double MEDIUM = 18.0;
// static const double LARGE = 20.0;
// static const double LARGER = 22.0;
// static const double XLARGE = 24.0;
// static const double HUGE = 28.0;
// static const double TITLE = 32.0;

TextStyle generateStyle({
  Color color,
  double size,
  FontWeight weight,
}) {
  return TextStyle(
    color: color,
    fontFamily: 'RobotoMono',
    fontFamilyFallback: ['Roboto'],
    fontSize: size,
    fontWeight: weight,
  );
}

TextStyle largeTitleStyle({
  Color color = Colors.white,
  double size = 28.0,
  FontWeight weight = MEDIUM,
}) {
  return generateStyle(color: color, size: size, weight: weight);
}

TextStyle mediumTitleStyle({
  Color color = Colors.white,
  double size = 24.0,
  FontWeight weight = MEDIUM,
}) {
  return generateStyle(color: color, size: size, weight: weight);
}

TextStyle smallTitleStyle({
  Color color = Colors.white,
  double size = 20.0,
  FontWeight weight = MEDIUM,
}) {
  return generateStyle(color: color, size: size, weight: weight);
}

TextStyle bodyStyle({
  Color color = Colors.white,
  double size = 16.0,
  FontWeight weight = NORMAL,
}) {
  return generateStyle(color: color, size: size, weight: weight);
}

TextStyle footnoteStyle({
  Color color = Colors.white,
  double size = 12.0,
  FontWeight weight = LIGHT,
}) {
  return generateStyle(color: color, size: size, weight: weight);
}

TextStyle hintStyle({
  Color color = LIGHT_GRAY,
  double size = 14.0,
  FontWeight weight = NORMAL,
}) {
  return generateStyle(color: color, size: size, weight: weight);
}

TextStyle buttonStyle({
  Color color = Colors.white,
  double size = 18.0,
  FontWeight weight = MEDIUM,
}) {
  return generateStyle(color: color, size: size, weight: weight);
}

// FOOTNOTE styles
// final FOOTNOTE_CHARCOAL_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: FOOTNOTE,
//   color: ColorThemes.CHARCOAL_GRAY,
// );
//
// final FOOTNOTE_SILVER = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: FOOTNOTE,
//   color: ColorThemes.SILVER,
// );
//
// // TINY size styles
// final TextStyle TINY_CHARCOAL_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: TINY,
//   color: ColorThemes.CHARCOAL_GRAY,
// );
// final TextStyle TINY_DARK_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: TINY,
//   color: ColorThemes.DARK_GRAY,
// );
// final TextStyle TINY_WHITE = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: TINY,
//   color: ColorThemes.WHITE,
// );
// final TextStyle TINY_SILVER = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: TINY,
//   color: ColorThemes.SILVER,
// );
// final TextStyle TINY_LIGHT_YELLOW = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: TINY,
//   color: ColorThemes.LIGHT_YELLOW,
// );
// final TextStyle TINY_LIGHT_BLUE = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: TINY,
//   color: ColorThemes.LIGHT_BLUE,
// );
//
// // SMALL size styles
// final TextStyle SMALL_LIGHT_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: SMALL,
//   color: ColorThemes.LIGHT_GRAY,
// );
// final TextStyle SMALL_CHARCOAL_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: SMALL,
//   color: ColorThemes.CHARCOAL_GRAY,
// );
// final TextStyle SMALL_DARK_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: SMALL,
//   color: ColorThemes.DARK_GRAY,
// );
//
// /// Font size: [SMALL], Color: [ColorThemes.WHITE]
// final TextStyle SMALL_WHITE = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: SMALL,
//   color: ColorThemes.WHITE,
// );
// final TextStyle SMALL_SILVER = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: SMALL,
//   color: ColorThemes.SILVER,
// );
//
// // MEDIUM size styles
// final TextStyle MEDIUM_DARK_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: MEDIUM,
//   color: ColorThemes.DARK_GRAY,
// );
//
// /// Font size: 18.0, Color: white
// final TextStyle MEDIUM_WHITE = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: MEDIUM,
//   color: ColorThemes.WHITE,
// );
// final TextStyle MEDIUM_CHARCOAL_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: MEDIUM,
//   color: ColorThemes.CHARCOAL_GRAY,
// );
//
// // LARGE size styles
// final TextStyle LARGE_LIGHT_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: LARGE,
//   color: ColorThemes.LIGHT_GRAY,
// );
// final TextStyle LARGE_WHITE = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: LARGE,
//   color: ColorThemes.WHITE,
// );
//
// // LARGER size styles
// final TextStyle LARGER_DARK_GRAY_BOLD = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: LARGER,
//   fontWeight: FontWeight.w300,
//   color: ColorThemes.DARK_GRAY,
// );
// final TextStyle LARGER_WHITE_BOLD = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: LARGER,
//   fontWeight: FontWeight.w300,
//   color: ColorThemes.WHITE,
// );
// final TextStyle LARGER_CHARCOAL_GRAY_BOLD = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: LARGER,
//   fontWeight: FontWeight.w300,
//   color: ColorThemes.CHARCOAL_GRAY,
// );
//
// // XLARGE size styles
// final XLARGE_GRANITE_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: XLARGE,
//   color: ColorThemes.GRANITE_GRAY,
// );
//
// // HUGE size styles
// final HUGE_GRANITE_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: HUGE,
//   color: ColorThemes.GRANITE_GRAY,
// );
// final HUGE_OFF_WHITE = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: HUGE,
//   color: ColorThemes.OFF_WHITE,
// );
// final HUGE_WHITE = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: HUGE,
//   color: ColorThemes.WHITE,
// );
//
// // TITLE size styles
// final TITLE_GRANITE_GRAY = TextStyle(
//   fontFamily: 'RobotoMono',
//   fontSize: TITLE,
//   color: ColorThemes.GRANITE_GRAY,
// );
