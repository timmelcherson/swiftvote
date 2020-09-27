

import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/screens/app_scaffold.dart';
import 'package:swiftvote/screens/vote_page/vote_barrel.dart';

class VoteScaffold extends StatelessWidget {

  final Vote vote;

  VoteScaffold({this.vote});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: VoteWidget(vote: vote),
    );
  }
}