import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/settings_screen/settings_list_item.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/widget_keys.dart';

class SettingsScreen extends StatelessWidget {
  List<String> titles = [
    "title.interests",
    "title.collection",
    "title.my_information",
    "title.invite_friends",
    "title.help_and_support",
    "title.notifications",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.settingsWidget,
      bottomNavigationBar: MainNavBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                trans(context, 'title.settings'),
                style: largeTitleStyle(),
              ),
            ),
            for (var title in titles)
              SettingsListItem(title: trans(context, title)),
            FlatButton(
              color: OFF_WHITE,
              child: Text('Intro Screen'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(Routes.LOGIN);
              },
            ),
            FlatButton(
              color: OFF_WHITE,
              child: Text('Sign out'),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
                Navigator.of(context, rootNavigator: true).pushNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
