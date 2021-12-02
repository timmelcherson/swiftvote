import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/themes/color_themes.dart';

class VoteListResultBars extends StatelessWidget {
  final Vote vote;
  final double firstBarLength;
  final double secondBarLength;

  const VoteListResultBars({
    required this.vote,
    required this.firstBarLength,
    required this.secondBarLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 4,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    print(constraints);
                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedContainer(
                          curve: Curves.easeInOutQuad,
                          duration: Duration(milliseconds: 1500),
                          width: constraints.maxWidth * firstBarLength,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: PRIMARY_BLUE,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            vote.voteOptions[0],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${firstBarLength * 100}%',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 48.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    print(constraints);
                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedContainer(
                          curve: Curves.easeInOutQuad,
                          duration: Duration(milliseconds: 1500),
                          width: constraints.maxWidth * secondBarLength,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: PRIMARY_YELLOW,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            vote.voteOptions[1],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${secondBarLength * 100}%',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
