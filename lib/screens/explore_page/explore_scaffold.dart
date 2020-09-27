

import 'package:flutter/material.dart';
import 'package:swiftvote/screens/app_scaffold.dart';
import 'package:swiftvote/screens/explore_page/explore_barrel.dart';

class ExploreScaffold extends StatelessWidget {


  ExploreScaffold();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ExploreWidget(),
    );
  }
}