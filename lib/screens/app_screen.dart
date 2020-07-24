import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/models/models.dart';
import 'package:swiftvote/widgets/widgets.dart';

class AppScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          body: getWidget(activeTab),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }

  Widget getWidget(AppTab activeTab) {
    switch (activeTab) {
      case AppTab.explore:
        return ExploreWidget();
      case AppTab.search:
        return SearchWidget();
      case AppTab.home:
        return HomeWidget();
      case AppTab.notifications:
        return NotificationsWidget();
      case AppTab.settings:
        return SettingsWidget();
      default:
        return HomeWidget();
    }
  }
}
