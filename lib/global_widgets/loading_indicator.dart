import 'package:flutter/material.dart';
import 'package:swiftvote/constants/widget_keys.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator() : super(key: Keys.loadingIndicator);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}