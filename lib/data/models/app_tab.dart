import 'package:flutter/material.dart';
import 'package:swiftvote/constants/swiftvote_widget_keys.dart';

enum AppTab { explore, search, vote, notifications, settings }

extension AppTabIcon on AppTab {

  static const icons = {
    AppTab.explore: Icons.explore,
    AppTab.search: Icons.search,
    AppTab.vote: Icons.home,
    AppTab.notifications: Icons.notifications,
    AppTab.settings: Icons.settings,
  };

  static const keys = {
    AppTab.explore: SwiftvoteWidgetKeys.exploreTab,
    AppTab.search: SwiftvoteWidgetKeys.searchTab,
    AppTab.vote: SwiftvoteWidgetKeys.homeTab,
    AppTab.notifications: SwiftvoteWidgetKeys.notificationsTab,
    AppTab.settings: SwiftvoteWidgetKeys.settingsTab,
  };

  IconData get icon => icons[this];

  Key get key => keys[this];
}