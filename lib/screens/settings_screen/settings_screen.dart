import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/settings_screen/interests_list.dart';
import 'package:swiftvote/screens/settings_screen/my_information.dart';
import 'package:swiftvote/screens/settings_screen/settings_list_item.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/widget_keys.dart';

class SettingsScreen extends StatelessWidget {
  List<String> _titles = [
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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: SECONDARY_BG,
        title: Text("Settings")
      ),
      key: Keys.settingsWidget,
      backgroundColor: SECONDARY_BG,
      body: SafeArea(
        child: CustomScrollView(
          key: Keys.exploreWidget,
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            // SliverAppBar(
            //   pinned: true,
            //   collapsedHeight: 60.0,
            //   expandedHeight: 60.0,
            //   title: Text(
            //     trans(context, 'title.settings'),
            //     style: largeTitleStyle(),
            //   ),
            // ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // SettingsListItem(title: trans(context, _titles[0]), listItems: [InterestsList()]),
                  // SettingsListItem(title: trans(context, _titles[1]), listItems: [InterestsList()]),
                  SettingsListItem(title: trans(context, _titles[2]), listItems: [MyInformation()]),
                  SettingsListItem(title: 'My discussions', listItems: [Text('Who is best artist', style: bodyStyle(),)]),
                ],
              ),
              // delegate: SliverChildBuilderDelegate(
              //   (BuildContext context, int index) {
              //     print('index: $index');
              //     return SettingsListItem(title: trans(context, _titles[index]));
              //   },
              //   childCount: _titles.length,
            ),
          ],
        ),

        // ListView(
        //   children: [
        //     FlatButton(
        //       color: OFF_WHITE,
        //       child: Text('Intro Screen'),
        //       onPressed: () {
        //         Navigator.of(context, rootNavigator: true).pushNamed(Routes.LOGIN);
        //       },
        //     ),
        //     FlatButton(
        //       color: OFF_WHITE,
        //       child: Text('Sign out'),
        //       onPressed: () {
        //         BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
        //         Navigator.of(context, rootNavigator: true).pushNamed(Routes.LOGIN);
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
