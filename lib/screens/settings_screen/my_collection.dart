import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/vote_model.dart';

class MyCollection extends StatelessWidget {
  final List<Vote> votes;

  const MyCollection({Key? key, this.votes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(votes.length, (index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          child: Text(votes[index].title),
        );
      }),
    );
  }
}
