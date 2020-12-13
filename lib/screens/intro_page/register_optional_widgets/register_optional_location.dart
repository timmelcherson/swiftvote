import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:location/location.dart';

typedef void LocationScreenCallback(String gender);

class RegisterOptionalLocation extends StatefulWidget {

  final LocationScreenCallback locationScreenCallback;

  RegisterOptionalLocation({@required this.locationScreenCallback});

  @override
  State createState() => _RegisterOptionalLocationState();
}

class _RegisterOptionalLocationState extends State<RegisterOptionalLocation> {

  Function _callback;

  @override
  void initState() {
    super.initState();
    _callback = widget.locationScreenCallback;
  }

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
                  style: TextThemes.TITLE_GRANITE_GRAY,
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
                    color: ColorThemes.PRIMARY_BLUE,
                  ),
                  hintText: 'Search',
                  hintStyle: TextThemes.LARGE_LIGHT_GRAY,
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
