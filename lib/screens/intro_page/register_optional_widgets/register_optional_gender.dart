import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';



// typedef OnCallback = Function(String gender);

class RegisterOptionalGender extends StatefulWidget {

  // final OnCallback callback;
  //
  // RegisterOptionalGender({this.callback});

  @override
  State createState() => _RegisterOptionalGenderState();
}

class _RegisterOptionalGenderState extends State<RegisterOptionalGender> {
  List<bool> _checked = [false, false, false];
  List<String> _genders = ['Male', 'Female', 'Other'];
  String _selectedGender = '';


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Gender',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _genders.length; i++)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _genders[i],
                      style: TextThemes.mediumGrayTextStyle,
                    ),
                    Checkbox(
                      value: _checked[i],
                      onChanged: (value) {
                        // setState(() {
                        //   _checked[i] = value;
                        //   widget.callback(_genders[i]);
                        // });
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
