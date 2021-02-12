import 'package:flutter/material.dart';

class SettingsListItem extends StatefulWidget {
  final String title;
  final listItems;

  SettingsListItem({
    @required this.title,
    this.listItems,
  });

  @override
  _SettingsListItemState createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> {
  String _title;
  var _listItems;
  bool _open;

  @override
  void initState() {
    _open = false;
    _title = widget.title;
    _listItems = widget.listItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(_title),
      trailing: _open ? Icon(Icons.keyboard_arrow_down_sharp) : Icon(Icons.keyboard_arrow_right_sharp),
      children: [
        Text('OPENED'),
      ],
      onExpansionChanged: (value) => setState(() => _open = value),
    );
  }
}
