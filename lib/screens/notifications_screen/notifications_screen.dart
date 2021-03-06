import 'package:flutter/material.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';

class NotificationsScreen extends StatelessWidget {

  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.notificationsWidget,
      bottomNavigationBar: MainNavBar(),
      body: GestureDetector(
        onPanStart: (panstart) {
          print(panstart);
        },
        onPanUpdate: (panupdate) {
          print(panupdate);
        },
        onVerticalDragStart: (dragDetails) {
          startVerticalDragDetails = dragDetails;
          print(dragDetails);
        },
        onVerticalDragUpdate: (dragDetails) {
          updateVerticalDragDetails = dragDetails;
          print(dragDetails);
        },
        onVerticalDragEnd: (endDetails) {
          double dx = updateVerticalDragDetails.globalPosition.dx -
              startVerticalDragDetails.globalPosition.dx;
          double dy = updateVerticalDragDetails.globalPosition.dy -
              startVerticalDragDetails.globalPosition.dy;
          double velocity = endDetails.primaryVelocity;
          print(endDetails);

          print(velocity);
        },
        child: Center(
          child: Text('Notifications Screen'),
        ),
      ),
    );
  }
}
