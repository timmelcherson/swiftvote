import 'package:flutter/material.dart';
import 'package:swiftvote/utils/keys.dart';

enum AppTab { explore, search, home, notifications, settings }

extension AppTabIcon on AppTab {

  static const icons = {
    AppTab.explore: Icons.explore,
    AppTab.search: Icons.search,
    AppTab.home: Icons.home,
    AppTab.notifications: Icons.notifications,
    AppTab.settings: Icons.settings,
  };

  static const keys = {
    AppTab.explore: SwiftvoteKeys.exploreTab,
    AppTab.search: SwiftvoteKeys.searchTab,
    AppTab.home: SwiftvoteKeys.homeTab,
    AppTab.notifications: SwiftvoteKeys.notificationsTab,
    AppTab.settings: SwiftvoteKeys.settingsTab,
  };

  IconData get icon => icons[this];

  Key get key => keys[this];
}