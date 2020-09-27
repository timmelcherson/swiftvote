import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/screens/screens.dart';
import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/widgets/widgets.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  AppScaffold({@required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabSelector(
        activeTab: getActiveTab(),
        onTabSelected: (tab) => {
          BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          Navigator.pushReplacementNamed(context, getRoute(tab)),
        },
      ),
      body: SafeArea(child: this.body),
    );
  }

  String getRoute(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return Routes.home;
      case AppTab.explore:
        return Routes.explore;
      default:
        return Routes.home;
    }
  }

  AppTab getActiveTab() {
    switch (this.body.runtimeType) {
      case VoteWidget:
        print('voteWidget is the body');
        return AppTab.home;
      case ExploreWidget:
        print('voteWidget is the body');
        return AppTab.explore;
      default:
        return AppTab.home;
    }
  }
}
