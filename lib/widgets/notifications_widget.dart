import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/keys.dart';


class NotificationsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteKeys.notificationsWidget,
      body: Container(
        color: Color.fromRGBO(123, 239, 178, 1),
        child: Center(
          child: Text('Notifications Widget'),
        ),
      ),
    );
  }
}