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
    return SizedBox(
      height: 58,
      child: BottomNavigationBar(
        key: SwiftvoteKeys.tabs,
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) => {onTabSelected(AppTab.values[index])},
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
              title: Text('title'),
              icon: tab == AppTab.home
                  ? (activeTab == AppTab.home
                      ? Container(
                          height: 57,
                          width: 54,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: SwiftvoteTheme.primaryColorAccent,
                                  width: 3),
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/vote_icon_selected.svg',
                            height: 56.0,
                            allowDrawingOutsideViewBox: true,
                          ))
                      : Container(
                          height: 57,
                          width: 54,
                          child: SvgPicture.asset(
                            'assets/icons/vote_icon_unselected.svg',
                            height: 56.0,
                            allowDrawingOutsideViewBox: true,
                          )))
                  : (tab == activeTab
                      ? Container(
                          height: 57,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: SwiftvoteTheme.primaryColorAccent,
                                  width: 3),
                            ),
                          ),
                          child: Icon(
                            tab.icon,
                            key: tab.key,
                            size: 30.0,
                          ),
                        )
                      : Container(
                          height: 57,
                          width: 50,
                          child: Icon(
                            tab.icon,
                            key: tab.key,
                            size: 24.0,
                          ),
                        )));
        }).toList(),
        backgroundColor: SwiftvoteTheme.secondaryColor,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: SwiftvoteTheme.primaryColorAccent,
        unselectedItemColor: SwiftvoteTheme.primaryColor,
      ),
    );
  }
}