import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';


class SettingsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteWidgetKeys.settingsWidget,
      body: Container(
        color: Color.fromRGBO(235, 149, 50, 1),
        child: Center(
          child: Text('Settings Widget'),
        ),
      ),
    );
  }
}