import 'package:flutter/material.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';


class NotificationsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteWidgetKeys.notificationsWidget,
      body: Container(
        color: Color.fromRGBO(123, 239, 178, 1),
        child: Center(
          child: Text('Notifications Widget'),
        ),
      ),
    );
  }
}