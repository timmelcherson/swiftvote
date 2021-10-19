import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/settings_screen/interests_list.dart';
import 'package:swiftvote/screens/settings_screen/my_information.dart';
import 'package:swiftvote/screens/settings_screen/my_collection.dart';
import 'package:swiftvote/screens/settings_screen/settings_accordion.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/widget_keys.dart';

class SettingsScreen extends StatelessWidget {
  final Map<String, String> _titles = {
    "interests": "title.interests",
    "collection": "title.collection",
    "my_information": "title.my_information",
    "invite_friends": "title.invite_friends",
    "help_and_support": "title.help_and_support",
    "notifications": "title.notifications",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: SECONDARY_BG,
          title: Text("Settings")),
      key: Keys.settingsWidget,
      backgroundColor: SECONDARY_BG,
      body: SafeArea(child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsReadyState) {
            return CustomScrollView(
              key: Keys.exploreWidget,
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SettingsAccordion(
                          title: trans(context, _titles["my_information"]),
                          content: [
                            MyInformation(
                              userProfile: state.userProfile,
                            )
                          ]),
                      SettingsAccordion(
                        title: trans(context, _titles["collection"]),
                        content: [MyCollection(votes: state.votes)],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return LoadingIndicator();
        },
      )),
    );
  }
}
