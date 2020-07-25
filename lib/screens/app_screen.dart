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
    Widget widget;
    switch (activeTab) {
      case AppTab.explore:
        widget = ExploreWidget();
        break;
//        return ExploreWidget();
      case AppTab.search:
        widget = SearchWidget();
        break;
//        return SearchWidget();
      case AppTab.home:
        widget = HomeWidget();
        break;
//        return HomeWidget();
      case AppTab.notifications:
        widget = NotificationsWidget();
        break;
//        return NotificationsWidget();
      case AppTab.settings:
        widget = SettingsWidget();
        break;
//        return SettingsWidget();
      default:
        widget = HomeWidget();
        break;
    }
    return SafeArea(child: widget);
  }
}
