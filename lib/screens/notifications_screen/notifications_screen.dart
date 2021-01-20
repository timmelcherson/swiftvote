import 'package:flutter/material.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.notificationsWidget,
      bottomNavigationBar: MainNavBar(),
      body: Center(
        child: Text('Notifications Screen'),
      ),
    );
  }
}
