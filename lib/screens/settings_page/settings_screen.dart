import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/swiftvote_widget_keys.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteWidgetKeys.settingsWidget,
      body: Container(
        color: Color.fromRGBO(235, 149, 50, 1),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Settings Widget'),
              FlatButton(
                color: ColorThemes.secondaryColor,
                child: Text('Sign out'),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogOutEvent());
                  Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
