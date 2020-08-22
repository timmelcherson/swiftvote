import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/models/models.dart';
import 'package:swiftvote/repositories/vote_repository.dart';
import 'package:swiftvote/utils/file_storage.dart';
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
                  {BlocProvider.of<TabBloc>(context).add(TabUpdated(tab))}),
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
      case AppTab.search:
        widget = SearchWidget();
        break;
      case AppTab.home:
        widget = VoteWidget();
        break;
      case AppTab.notifications:
        widget = NotificationsWidget();
        break;
      case AppTab.settings:
        widget = SettingsWidget();
        break;
      default:
        widget = VoteWidget();
        break;
    }
    return SafeArea(
      child: Container(
        color: Color.fromRGBO(255, 253, 245, 1),
        child: widget,
      ),
    );
  }
}