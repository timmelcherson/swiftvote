import 'package:flutter/material.dart';
import 'package:swiftvote/themes/text_themes.dart';

class MyInformation extends StatefulWidget {
  const MyInformation({Key key}) : super(key: key);

  @override
  _MyInformationState createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Gender', style: bodyStyle(size: 14.0)),
                Text('Male', style: bodyStyle(size: 14.0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Age', style: bodyStyle(size: 14.0)),
                Text('27', style: bodyStyle(size: 14.0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Location', style: bodyStyle(size: 14.0)),
                Text('Stockholm, Sweden', style: bodyStyle(size: 14.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
