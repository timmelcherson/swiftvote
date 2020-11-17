import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:location/location.dart';

class RegisterLocation extends StatefulWidget {


  @override
  State createState() => _RegisterLocationState();
}

class _RegisterLocationState extends State<RegisterLocation> {


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 48.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Location',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: ColorThemes.primaryColor,
            ),
            hintText: 'Search',
            hintStyle: TextThemes.textHintStyle,
          ),
          autovalidateMode: AutovalidateMode.disabled,
          autocorrect: false,
        ),
      ],
    );
  }
}