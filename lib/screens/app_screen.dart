import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/swiftvote_widget_keys.dart';
import 'screens.dart';

class AppScreen extends StatelessWidget {
  final appScreenNavigatorKey = GlobalKey<NavigatorState>();
  final Vote vote;
  final User user;
  final AppTab tabFromRoute;

  AppScreen({Key key, this.vote, this.user, this.tabFromRoute})
      : super(key: key ?? SwiftvoteWidgetKeys.appScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          backgroundColor: ColorThemes.lightYellowBackgroundColor,
          body: SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                if (appScreenNavigatorKey.currentState.canPop()) {
                  appScreenNavigatorKey.currentState.pop();
                  return false;
                }
                return true;
              },
              child: Navigator(
                key: appScreenNavigatorKey,
                initialRoute: Routes.HOME,
                onGenerateRoute: (RouteSettings settings) {
                  Widget currentWidget;
                  print('IN HERE WITH ROUTE: ${settings.name}');

                  if (settings.name == null) {
                    return null;
                  }

                  if (settings.arguments != null) {
                    currentWidget = _getWidgetWithArgs(settings.name, settings.arguments);
                  } else {
                    currentWidget = _getWidget(settings.name);
                  }

                  BlocProvider.of<TabBloc>(context)
                      .add(TabUpdated(_getTabFromRoute(settings.name)));

                  return PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => currentWidget,
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = Offset(0.0, 0.05);
                      var end = Offset.zero;
                      var tween = Tween(begin: begin, end: end);
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    transitionDuration: Duration(milliseconds: 300),
                    maintainState: true,
                  );
                },
              ),
            ),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => {
              BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
              appScreenNavigatorKey.currentState.pushNamed(_getRouteName(tab))
            },
          ),
        );
      },
    );
  }

  AppTab _getTabFromRoute(String routeName) {
    switch (routeName) {
      case Routes.HOME:
        return AppTab.vote;
      case '/selected_vote':
        return AppTab.vote;
      case Routes.VOTE_RESULT:
        return AppTab.vote;
      case Routes.EXPLORE:
        return AppTab.explore;
      case Routes.SEARCH:
        return AppTab.search;
      case Routes.NOTIFICATIONS:
        return AppTab.notifications;
      case Routes.SETTINGS:
        return AppTab.settings;
      default:
        throw Exception('Invalid route: $routeName');
    }
  }

  String _getRouteName(AppTab tab) {
    switch (tab) {
      case AppTab.vote:
        return Routes.HOME;
      case AppTab.explore:
        return Routes.EXPLORE;
      case AppTab.search:
        return Routes.SEARCH;
      case AppTab.notifications:
        return Routes.NOTIFICATIONS;
      case AppTab.settings:
        return Routes.SETTINGS;
      default:
        return Routes.HOME;
    }
  }

  Widget _getWidget(String routeName) {
    Widget widget;
    switch (routeName) {
      case Routes.HOME:
        widget = VoteWidget();
        break;
      case Routes.EXPLORE:
        widget = ExploreWidget();
        break;
      case Routes.SEARCH:
        widget = SearchWidget();
        break;
      case Routes.NOTIFICATIONS:
        widget = NotificationsScreen();
        break;
      case Routes.SETTINGS:
        widget = SettingsScreen();
        break;
      case Routes.VOTE_RESULT:
        widget = VoteResultWidget();
        break;
      default:
        throw Exception('Invalid route: $routeName');
    }
    return widget;
  }

  Widget _getWidgetWithArgs(String routeName, Object args) {
    switch (routeName) {
      case '/selected_vote':
        if (args.runtimeType != Vote) {
          return Container(
            child: Text('ERROR'),
          );
        } else {
          return VoteWidget(vote: args);
        }
        break;
      default:
        throw Exception('Invalid route: $routeName');
    }
  }
}
