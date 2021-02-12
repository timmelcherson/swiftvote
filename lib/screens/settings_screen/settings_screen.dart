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
                AppLocalizations.trans(context, 'title.settings'),
                style: TextThemes.HUGE_WHITE,
              ),
            ),
            for (var title in titles)
              SettingsListItem(title: AppLocalizations.trans(context, title)),
            FlatButton(
              color: ColorThemes.OFF_WHITE,
              child: Text('Intro Screen'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(Routes.LOGIN);
              },
            ),
            FlatButton(
              color: ColorThemes.OFF_WHITE,
              child: Text('Sign out'),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogOutEvent());
                Navigator.of(context, rootNavigator: true).pushNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
