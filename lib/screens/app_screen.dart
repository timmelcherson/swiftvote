import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/widgets/widgets.dart';
import 'screens.dart';

class AppScreen extends StatelessWidget {
  final appScreenNavigatorKey = GlobalKey<NavigatorState>();
  final Vote vote;
  final AppTab tabFromRoute;
  final Widget activeWidget;

  AppScreen({Key key, this.vote, this.tabFromRoute, this.activeWidget})
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
                initialRoute: Routes.home,
                onGenerateRoute: (RouteSettings settings) {
                  Widget currentWidget;

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
      case '/':
        return AppTab.home;
      case '/selected_vote':
        return AppTab.home;
      case '/explore':
        return AppTab.explore;
      case '/search':
        return AppTab.search;
      default:
        throw Exception('Invalid route: $routeName');
    }
  }

  String _getRouteName(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return Routes.home;
      case AppTab.explore:
        return Routes.explore;
      case AppTab.search:
        return Routes.search;
      default:
        return Routes.home;
    }
  }

  Widget _getWidget(String routeName) {
    Widget widget;
    switch (routeName) {
      case '/':
        widget = VoteWidget();
        break;
      case '/explore':
        widget = ExploreWidget();
        break;
      case '/search':
        widget = SearchWidget();
        break;
      default:
        throw Exception('Invalid route: ${routeName}');
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
        throw Exception('Invalid route: ${routeName}');
    }
  }
}
