import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class SettingsAccordion extends StatefulWidget {
  final String title;
  final List<Widget> content;

  SettingsAccordion({
    @required this.title,
    this.content,
  });

  @override
  _SettingsAccordionState createState() => _SettingsAccordionState();
}

class _SettingsAccordionState extends State<SettingsAccordion> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  String _title;
  var _content;
  bool _open;

  @override
  void initState() {
    _open = false;
    _title = widget.title;
    _content = widget.content;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      upperBound: 0.25,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(0),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(_title, style: bodyStyle()),
      trailing: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
        child: Icon(Icons.keyboard_arrow_right_sharp, size: 20, color: Colors.white),
      ),
      onExpansionChanged: (value) => setState(() {
        _open = value;
        _open ? _animationController.forward() : _animationController.reverse();
      }),
      children: _content,
    );
  }
}
