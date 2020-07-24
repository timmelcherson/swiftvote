import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/keys.dart';


class ExploreWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteKeys.exploreWidget,
      body: Container(
        color: Color.fromRGBO(25, 181, 254, 1),
        child: Center(
          child: Text('Explore Widget'),
        ),
      ),
    );
  }
}