import 'package:flutter/material.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/themes/text_themes.dart';

class MyInformation extends StatefulWidget {
  final UserProfile userProfile;

  const MyInformation({required this.userProfile}) : super(key: Keys.myInformation);

  @override
  _MyInformationState createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  late String _age;
  late String _gender;
  late String _location;

  bool _editGender = false;

  @override
  void initState() {
    super.initState();
    _age = widget.userProfile.age.toString().isNotEmpty
        ? widget.userProfile.age.toString()
        : "Not set";
    _gender = widget.userProfile.gender.isNotEmpty
        ? widget.userProfile.gender
        : "Not set";
    _location = widget.userProfile.location.isNotEmpty
        ? widget.userProfile.location
        : "Not set";

    _genderController.text = _gender;
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          // Padding(
          //   padding:
          //       const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       Expanded(
          //         child: Text('Gender', style: bodyStyle(size: 14.0)),
          //       ),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () => setState(() => _editGender = true),
          //           child: TextField(
          //             controller: _genderController,
          //             style: bodyStyle(size: 14.0),
          //             textAlign: TextAlign.right,
          //             decoration: InputDecoration(
          //               enabled: _editGender,
          //               border: InputBorder.none,
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Gender', style: bodyStyle(size: 14.0)),
                Text(_gender, style: bodyStyle(size: 14.0)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Age', style: bodyStyle(size: 14.0)),
                Text(_age, style: bodyStyle(size: 14.0)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Location', style: bodyStyle(size: 14.0)),
                Text(_location, style: bodyStyle(size: 14.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
