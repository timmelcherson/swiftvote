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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Gender', style: bodyStyle(size: 14.0)),
              Text('Male / Female / Stone', style: bodyStyle(size: 14.0)),
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
              Text('Elderly', style: bodyStyle(size: 14.0)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Language', style: bodyStyle(size: 14.0)),
              Text('SVENSKA SÅKLART', style: bodyStyle(size: 14.0)),
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
              Text('Livland', style: bodyStyle(size: 14.0)),
            ],
          ),
        ),
      ],
    );
  }
}
