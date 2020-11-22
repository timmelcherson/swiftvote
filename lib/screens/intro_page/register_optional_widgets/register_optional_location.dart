import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:location/location.dart';

class RegisterOptionalLocation extends StatefulWidget {
  @override
  State createState() => _RegisterOptionalLocationState();
}

class _RegisterOptionalLocationState extends State<RegisterOptionalLocation> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    double _safeAreaPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 2 * _safeAreaPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: Text(
                  'Location',
                  style: TextThemes.largeTitleTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32.0),
              child: TextFormField(
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
            ),
          ],
        ),
      ),
    );
  }
}
