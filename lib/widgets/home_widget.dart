import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/keys.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';


class HomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteKeys.homeWidget,
      body: Container(
        color: SwiftvoteTheme.primaryColorAccent,
        child: Center(
          child: Text('Home Widget'),
        ),
      ),
    );
  }
}