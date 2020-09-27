import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
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
          body: WillPopScope(
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
                print('onGenerateRoute settings: $settings');
                WidgetBuilder builder;
                // Manage your route names here


                // if (settings.arguments != null) {
                //   print('has args: ${settings.arguments}');
                //   builder = _getWidgetBuilderWithArgs(settings.name, settings.arguments);
                // }
                // else {
                //   builder = _getWidgetBuilder(settings.name);
                // }


                BlocProvider.of<TabBloc>(context).add(TabUpdated(_getTabFromRoute(settings.name)));
                // switch (settings.name) {
                //   case '/':
                //     builder = (BuildContext context) => VoteWidget();
                //     break;
                //   case '/explore':
                //     builder = (BuildContext context) => ExploreWidget();
                //     break;
                //   case '/search':
                //     builder = (BuildContext context) => SearchWidget();
                //     break;
                //   default:
                //     throw Exception('Invalid route: ${settings.name}');
                // }
                // You can also return a PageRouteBuilder and
                // define custom transitions between pages
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => _getWidget(settings.name),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 1000),
                );
                // return MaterialPageRoute(
                //   builder: builder,
                //   settings: settings,
                // );
              },
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

  // Widget getWidget(AppTab activeTab) {
  //   Widget widget;
  //   switch (activeTab) {
  //     case AppTab.explore:
  //       widget = ExploreWidget();
  //       break;
  //     case AppTab.search:
  //       widget = SearchWidget();
  //       break;
  //     case AppTab.home:
  //       widget = VoteWidget();
  //       break;
  //     case AppTab.notifications:
  //       widget = NotificationsWidget();
  //       break;
  //     case AppTab.settings:
  //       widget = SettingsWidget();
  //       break;
  //     default:
  //       widget = VoteWidget();
  //       break;
  //   }
  //
  //   return SafeArea(
  //     child: Container(
  //       color: Color.fromRGBO(255, 253, 245, 1),
  //       child: widget,
  //     ),
  //   );
  // }

  AppTab _getTabFromRoute(String routeName) {
    print('_getTabFromRoute: $routeName');
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
  // WidgetBuilder _getWidgetBuilder(String routeName) {
  //   Widget widget;
  //   switch (routeName) {
  //     case '/':
  //       return (BuildContext context) => VoteWidget();
  //     case '/explore':
  //       return (BuildContext context) => ExploreWidget();
  //     case '/search':
  //       return (BuildContext context) => SearchWidget();
  //     default:
  //       throw Exception('Invalid route: ${routeName}');
  //   }
  // }

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

  WidgetBuilder _getWidgetBuilderWithArgs(String routeName, Object args) {
    print('PASSED ARGS ARE: $args');
    switch (routeName) {
      case '/selected_vote':
        if (args.runtimeType != Vote) {
          print('IT WAS NOT A VOTE, IT WAS A: ${args.runtimeType}');
          return (BuildContext context) => VoteWidget();
        }
        else {
          print('IT WAS A VOTE!!!');
          return (BuildContext context) => VoteWidget(vote: args);
        }
        break;

      default:
        throw Exception('Invalid route: ${routeName}');
    }
  }


}
