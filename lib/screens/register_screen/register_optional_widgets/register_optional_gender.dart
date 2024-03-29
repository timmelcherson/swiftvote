import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';



typedef void GenderScreenCallback(String gender);

class RegisterOptionalGender extends StatefulWidget {

  final GenderScreenCallback genderScreenCallback;

  RegisterOptionalGender({required this.genderScreenCallback});

  @override
  State createState() => _RegisterOptionalGenderState();
}

class _RegisterOptionalGenderState extends State<RegisterOptionalGender> {

  late int checkedIndex;
  List<String> _genders = ['Male', 'Female', 'Other'];
  late Function _callback;

  @override
  void initState() {
    super.initState();
    _callback = widget.genderScreenCallback;
  }

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
              style: smallTitleStyle(color: CHARCOAL_GRAY),
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
                      style: bodyStyle(color: CHARCOAL_GRAY),
                    ),
                    Checkbox(
                      value: checkedIndex == i,
                      onChanged: (value) {
                        setState(() {
                          checkedIndex = i;
                          _callback(_genders[i]);
                        });
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
