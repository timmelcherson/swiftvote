import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/navigation/navigation.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/global_widgets/main_navbar_item.dart';
import 'package:swiftvote/themes/themes.dart';

class MainNavBar extends StatefulWidget {
  @override
  _MainNavBarState createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  final List<Map<String, dynamic>> navItems = [
    {
      'route': Routes.EXPLORE,
      'iconData': Icons.explore_outlined,
      'iconPath': 'assets/icons/explore_icon.svg',
      'name': 'HOME_SCREEN_NAVBAR_ITEM',
    },
    {
      'route': Routes.ADD_VOTE,
      'iconData': Icons.add,
      'iconPath': 'assets/icons/add_icon.svg',
      'name': 'INVOICES_SCREEN_NAVBAR_ITEM',
    },
    {
      'route': Routes.VOTE,
      'iconData': Icons.home_outlined,
      'iconPath': 'assets/icons/vote_list_icon.svg',
      'name': 'ORDER_TOOL_SCREEN_NAVBAR_ITEM',
    },
    {
      'route': Routes.NOTIFICATIONS,
      'iconData': Icons.notifications_none_outlined,
      'iconPath': 'assets/icons/notifications_icon.svg',
      'name': 'PAYMENTS_SCREEN_NAVBAR_ITEM',
    },
    {
      'route': Routes.SETTINGS,
      'iconData': Icons.settings_applications_outlined,
      'iconPath': 'assets/icons/settings_icon.svg',
      'name': 'MENU_SCREEN_NAVBAR_ITEM',
    },
  ];

  final double _navbarHeight = 74.0;
  final double _navbarBorderHeight = 60.0;
  final double _orderToolIconHeight = 58.0;

  double _orderToolIconBottom;

  @override
  void initState() {
    _orderToolIconBottom = _navbarHeight - _orderToolIconHeight;
    super.initState();
  }

  void onTapHandler(int tappedIndex) {
    if (ModalRoute.of(context).settings.name != navItems[tappedIndex]['route']) {
      BlocProvider.of<NavigationBloc>(context).add(MainNavBarTapEvent(index: tappedIndex));
      Navigator.of(context).pushNamed(navItems[tappedIndex]['route']);
    }
  }

  List<Widget> listWidget(int selectedIndex) {
    List<Widget> list = List.generate(
      navItems.length,
      (index) {
        return MainNavbarItem(
          iconData: navItems[index]['iconData'],
          iconPath: navItems[index]['iconPath'],
          isActive: selectedIndex == index,
          onTapCallback: () => onTapHandler(index),
          tag: navItems[index]['name'],
        );
      },
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is MainNavBarState) {
          return Material(
            color: ColorThemes.DEEP_BLUE_BG,
            child: SizedBox(
              height: _navbarBorderHeight,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: '123123',
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: _navbarBorderHeight,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: listWidget(state.index),
                  ),
                ],
              ),
            ),
          );
        }
        return LoadingIndicator();
      },
    );

    // return BlocBuilder<NavigationBloc, NavigationState>(
    //   builder: (context, state) {
    //     if (state is MainNavBarState) {
    //       return Hero(
    //         tag: Tags.MAIN_NAV_BAR_TAG,
    //         child: SizedBox(
    //           height: 60,
    //           child: Container(
    //             padding: EdgeInsets.only(top: 4.0),
    //             decoration: BoxDecoration(
    //               border: Border(
    //                 top: BorderSide(
    //                   width: 1.0,
    //                   color: Color.fromRGBO(239, 152, 154, 1),
    //                 ),
    //               ),
    //             ),
    //             child: BottomNavigationBar(
    //               key: Keys.tabs,
    //               currentIndex: state.index,
    //               onTap: onTapHandler,
    //               items: [
    //                 BottomNavigationBarItem(
    //                   label: 'label',
    //                   icon: Icon(
    //                     Icons.explore_outlined,
    //                     color: Color.fromRGBO(239, 152, 154, 1),
    //                   ),
    //                 ),
    //                 BottomNavigationBarItem(
    //                   label: 'label',
    //                   icon: Icon(
    //                     Icons.add,
    //                     size: 24,
    //                     color: Color.fromRGBO(239, 152, 154, 1),
    //                   ),
    //                 ),
    //                 BottomNavigationBarItem(
    //                   label: 'label',
    //                   icon: Icon(
    //                     Icons.home_outlined,
    //                     size: 24,
    //                     color: Color.fromRGBO(239, 152, 154, 1),
    //                   ),
    //                 ),
    //                 BottomNavigationBarItem(
    //                   label: 'label',
    //                   icon: Icon(
    //                     Icons.notifications_none_outlined,
    //                     size: 24,
    //                     color: Color.fromRGBO(239, 152, 154, 1),
    //                   ),
    //                 ),
    //                 BottomNavigationBarItem(
    //                   label: 'label',
    //                   icon: Icon(
    //                     Icons.settings_applications_outlined,
    //                     size: 24,
    //                     color: Color.fromRGBO(239, 152, 154, 1),
    //                   ),
    //                 ),
    //                 // AppTab.explore: Icons.explore,
    //                 // AppTab.search: Icons.search,
    //                 // AppTab.vote: Icons.home,
    //                 // AppTab.notifications: Icons.notifications,
    //                 // AppTab.settings: Icons.settings,
    //                 // Container(
    //                 //   height: 57,
    //                 //   width: 50,
    //                 //   decoration: BoxDecoration(
    //                 //     border: Border(
    //                 //       bottom: BorderSide(color: ColorThemes.OFF_WHITE, width: 3),
    //                 //     ),
    //                 //   ),
    //                 //   child: Icon(
    //                 //     tab.icon,
    //                 //     key: tab.key,
    //                 //     size: 30.0,
    //                 //   ),
    //                 // )
    //                 //     : Container(
    //                 //   height: 57,
    //                 //   width: 50,
    //                 //   child: Icon(
    //                 //     tab.icon,
    //                 //     key: tab.key,
    //                 //     size: 24.0,
    //                 //   ),
    //                 // )
    //               ],
    //               backgroundColor: ColorThemes.DEEP_BLUE_BG,
    //               selectedFontSize: 0.0,
    //               unselectedFontSize: 0.0,
    //               type: BottomNavigationBarType.fixed,
    //               selectedItemColor: ColorThemes.OFF_WHITE,
    //               unselectedItemColor: ColorThemes.LIGHT_GRAY,
    //             ),
    //           ),
    //         ),
    //       );
    //     }
    //     return SizedBox.expand(
    //       child: Center(
    //         child: Text('Something went wrong loading the navigation'),
    //       ),
    //     );
    //   },
    // );
  }
}
