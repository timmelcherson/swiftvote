import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/navigation/navigation.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/constants/widget_tags.dart';
import 'package:swiftvote/data/models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swiftvote/themes/themes.dart';

class MainNavBar extends StatelessWidget {
  static const mainNavBarRoutes = [
    Routes.EXPLORE,
    Routes.SEARCH,
    Routes.VOTE,
    Routes.NOTIFICATIONS,
    Routes.SETTINGS,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) {
      if (state is MainNavBarState) {
        return Hero(
          tag: Tags.MAIN_NAV_BAR_TAG,
          child: SizedBox(
            height: 60,
            child: Container(
              padding: EdgeInsets.only(top: 4.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Color.fromRGBO(239, 152, 154, 1),
                  ),
                ),
              ),
              child: BottomNavigationBar(
                key: Keys.tabs,
                currentIndex: state.index,
                onTap: (index) => {
                  if (index != state.index)
                    {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(MainNavBarTapEvent(selectedIndex: index)),
                      Navigator.of(context).pushNamed(mainNavBarRoutes[index])
                    }
                },
                items: [
                  BottomNavigationBarItem(
                    label: 'label',
                    icon: Icon(
                      Icons.explore,
                      size: 24,
                      color: Color.fromRGBO(239, 152, 154, 1),
                    ),
                    activeIcon: Icon(
                      Icons.explore,
                      size: 24,
                      color: Color.fromRGBO(241, 190, 191, 1),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'label',
                    icon: Icon(
                      Icons.search,
                      size: 24,
                      color: Color.fromRGBO(239, 152, 154, 1),
                    ),
                    activeIcon: Icon(
                      Icons.search,
                      size: 24,
                      color: Color.fromRGBO(241, 190, 191, 1),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'label',
                    icon: Icon(
                      Icons.home,
                      size: 24,
                      color: Color.fromRGBO(239, 152, 154, 1),
                    ),
                    activeIcon: Icon(
                      Icons.home,
                      size: 24,
                      color: Color.fromRGBO(241, 190, 191, 1),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'label',
                    icon: Icon(
                      Icons.notifications,
                      size: 24,
                      color: Color.fromRGBO(239, 152, 154, 1),
                    ),
                    activeIcon: Icon(
                      Icons.notifications,
                      size: 24,
                      color: Color.fromRGBO(241, 190, 191, 1),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'label',
                    icon: Icon(
                      Icons.settings,
                      size: 24,
                      color: Color.fromRGBO(239, 152, 154, 1),
                    ),
                    activeIcon: Icon(
                      Icons.settings,
                      size: 24,
                      color: Color.fromRGBO(241, 190, 191, 1),
                    ),
                  ),
                  // AppTab.explore: Icons.explore,
                  // AppTab.search: Icons.search,
                  // AppTab.vote: Icons.home,
                  // AppTab.notifications: Icons.notifications,
                  // AppTab.settings: Icons.settings,
                  // Container(
                  //   height: 57,
                  //   width: 50,
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       bottom: BorderSide(color: ColorThemes.OFF_WHITE, width: 3),
                  //     ),
                  //   ),
                  //   child: Icon(
                  //     tab.icon,
                  //     key: tab.key,
                  //     size: 30.0,
                  //   ),
                  // )
                  //     : Container(
                  //   height: 57,
                  //   width: 50,
                  //   child: Icon(
                  //     tab.icon,
                  //     key: tab.key,
                  //     size: 24.0,
                  //   ),
                  // )
                ],
                backgroundColor: ColorThemes.DEEP_BLUE_BG,
                selectedFontSize: 0.0,
                unselectedFontSize: 0.0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: ColorThemes.OFF_WHITE,
                unselectedItemColor: ColorThemes.LIGHT_GRAY,
              ),
            ),
          ),
        );
      }
      return SizedBox.expand(
        child: Center(
          child: Text('Something went wrong loading the navigation'),
        ),
      );
    });
  }
}
