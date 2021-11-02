import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/navigation/index.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/widget_tags.dart';
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
  ];

  final double _navbarHeight = 60.0;

  @override
  void initState() {
    super.initState();
  }

  void onTapHandler(int tappedIndex) {
    print("Tapped index: $tappedIndex");
    if (ModalRoute.of(context)!.settings.name !=
        navItems[tappedIndex]['route']) {
      BlocProvider.of<NavigationBloc>(context)
          .add(MainNavBarTapEvent(index: tappedIndex));
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
          onTapCallback: () {
            print(index);
            onTapHandler(index);
          },
          tag: navItems[index]['name'],
        );
      },
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: MAIN_NAV_BAR_TAG,
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is MainNavBarState) {
            return Material(
              color: SECONDARY_BG,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: _navbarHeight,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: listWidget(state.index),
                ),
              ),
            );
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
