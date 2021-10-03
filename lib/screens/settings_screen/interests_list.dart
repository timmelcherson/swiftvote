import 'package:flutter/material.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class InterestsList extends StatefulWidget {
  const InterestsList({Key key}) : super(key: key);

  @override
  _InterestsListState createState() => _InterestsListState();
}

class _InterestsListState extends State<InterestsList> {
  bool _val1 = false;
  bool _val2 = false;

  Color getFillColor(states) {
    print(states);
    if (states == MaterialState.selected) {
      return PRIMARY_BLUE;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trans(context, "interest.music"), style: bodyStyle(size: 14.0)),
              Switch(
                value: _val1,
                inactiveTrackColor: LIGHT_GRAY.withOpacity(0.4),
                inactiveThumbColor: LIGHT_GRAY,
                activeColor: PRIMARY_BLUE,
                onChanged: (value) => setState(() => _val1 = value),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trans(context, "interest.sports"), style: bodyStyle(size: 14.0)),
              Switch(
                value: _val2,
                inactiveTrackColor: LIGHT_GRAY.withOpacity(0.4),
                inactiveThumbColor: LIGHT_GRAY,
                activeColor: PRIMARY_BLUE,
                onChanged: (value) => setState(() => _val2 = value),
              )
            ],
          ),
        ),
      ],
    );
  }
}
