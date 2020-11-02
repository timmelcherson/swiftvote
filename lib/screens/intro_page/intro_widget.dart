import 'package:flutter/material.dart';
import 'package:swiftvote/screens/intro_page/intro_barrel.dart';
import 'package:swiftvote/themes/themes.dart';

class IntroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 32.0),
          color: Colors.white,
          child: WelcomeWidget(),
        ),
      ),
    );
  }
}
