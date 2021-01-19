import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/constants/swiftvote_widget_keys.dart';
import 'package:swiftvote/data/models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swiftvote/themes/themes.dart';

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
      height: 63,
      child: Container(
        padding: EdgeInsets.only(top: 4.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1.0,
              color: ColorThemes.OFF_WHITE,
            ),
          ),
        ),
        child: BottomNavigationBar(
          key: SwiftvoteWidgetKeys.tabs,
          currentIndex: AppTab.values.indexOf(activeTab),
          onTap: (index) => {
            if (AppTab.values[index] != activeTab) {onTabSelected(AppTab.values[index])}
          },
          items: AppTab.values.map((tab) {
            return BottomNavigationBarItem(
                label: 'Label',
                icon: tab == AppTab.vote
                    ? (activeTab == AppTab.vote
                        ? Container(
                            height: 57,
                            width: 54,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: ColorThemes.OFF_WHITE, width: 3),
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
                                bottom: BorderSide(color: ColorThemes.OFF_WHITE, width: 3),
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
          backgroundColor: ColorThemes.DEEP_BLUE_BG,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorThemes.OFF_WHITE,
          unselectedItemColor: ColorThemes.LIGHT_GRAY,
        ),
      ),
    );
  }
}
