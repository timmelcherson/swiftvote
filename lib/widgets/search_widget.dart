import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/keys.dart';


class SearchWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SwiftvoteKeys.searchWidget,
      body: Container(
        color: Color.fromRGBO(140, 20, 252, 1),
        child: Center(
          child: Text('Search Widget'),
        ),
      ),
    );
  }
}