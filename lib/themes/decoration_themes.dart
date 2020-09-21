import 'package:flutter/material.dart';

class DecorationThemes {
  static final BoxDecoration categoryBorder =
      BoxDecoration(border: Border.all(color: Color.fromRGBO(125, 125, 125, 1)));

  static final BoxShadow cardBoxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 3,
    offset: Offset(0, 5),
  );
}
