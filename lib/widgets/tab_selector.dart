import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/utils/keys.dart';
import 'package:swiftvote/models/models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: SwiftvoteKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => {onTabSelected(AppTab.values[index])},
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          title: Text('title'),
          icon: tab == AppTab.home
              ? SvgPicture.asset(
                  'assets/icons/vote_icon.svg',
                  height: 60.0,
                  allowDrawingOutsideViewBox: true,
                )
              : Icon(tab.icon, key: tab.key),
        );
      }).toList(),
      selectedFontSize: 0.0,
      unselectedFontSize: 0.0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: SwiftvoteTheme.primaryColorAccent,
      unselectedItemColor: SwiftvoteTheme.primaryColor,
    );
  }
}
