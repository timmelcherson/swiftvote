import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/keys.dart';


class SettingsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteKeys.settingsWidget,
      body: Container(
        color: Color.fromRGBO(235, 149, 50, 1),
        child: Center(
          child: Text('Settings Widget'),
        ),
      ),
    );
  }
}