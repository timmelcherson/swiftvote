import 'package:flutter/material.dart';

enum Lang { EN, SV }

extension LangExt on Lang {

  static const icons = {
    Lang.EN: Icons.flag,
    Lang.SV: Icons.flag,
  };

  static const languages = {
    Lang.EN: 'English',
    Lang.SV: 'Svenska',
  };

  IconData get icon => icons[this];

  String get lang => languages[this];
}

