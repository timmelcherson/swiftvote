import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class SettingsListItem extends StatefulWidget {
  final String title;
  final List<Widget> listItems;

  SettingsListItem({
    @required this.title,
    this.listItems,
  });

  @override
  _SettingsListItemState createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  String _title;
  var _listItems;
  bool _open;

  @override
  void initState() {
    _open = false;
    _title = widget.title;
    _listItems = widget.listItems;
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
        child: Icon(Icons.keyboard_arrow_right_sharp, size: 20, color: DARK_GRAY),
      ),
      onExpansionChanged: (value) => setState(() {
        _open = value;
        _open ? _animationController.forward() : _animationController.reverse();
      }),
      children: _listItems,
    );
  }
}
