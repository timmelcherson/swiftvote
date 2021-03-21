import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:intl/intl.dart';

typedef void DobScreenCallback(String dob);

class RegisterOptionalDob extends StatefulWidget {

  final DobScreenCallback dobScreenCallback;

  RegisterOptionalDob({@required this.dobScreenCallback});

  @override
  State createState() => _RegisterOptionalDobState();
}

class _RegisterOptionalDobState extends State<RegisterOptionalDob> {
  final List<String> days =
      List.generate(31, (index) => '${(1 + index).toString().padLeft(2, '0')}');
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> years = List.generate(90, (index) => '${2002 - index}');

  String _day;
  String _month;
  String _year;
  String _fullDate;
  Function _callback;

  @override
  void initState() {
    super.initState();
    _day = days[0];
    _month = months[0];
    _year = years[0];
    _callback = widget.dobScreenCallback;
  }

  @override
  Widget build(BuildContext context) {
    print(_day);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Date of Birth',
              style: largeTitleStyle(color: GRANITE_GRAY),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Day',
                    style: smallTitleStyle(color: CHARCOAL_GRAY),
                  ),
                  DropdownButton<String>(
                    value: _day,
                    style: bodyStyle(color: DARK_GRAY),
                    onChanged: (value) {
                      setState(() {
                        _day = value;
                        setDate();
                      });
                    },
                    items: days.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Month',
                    style: smallTitleStyle(color: CHARCOAL_GRAY),
                  ),
                  DropdownButton<String>(
                    value: _month,
                    style: bodyStyle(color: DARK_GRAY),
                    onChanged: (value) {
                      setState(() {
                        _month = value;
                        setDate();
                      });
                    },
                    items: months.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Year',
                    style: smallTitleStyle(color: CHARCOAL_GRAY),
                  ),
                  DropdownButton<String>(
                    value: _year,
                    style: bodyStyle(color: DARK_GRAY),
                    onChanged: (value) {
                      setState(() {
                        _year = value;
                        setDate();
                      });
                    },
                    items: years.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void setDate() {
    DateTime date = DateTime.parse(
        _year + '-' + '${(months.indexOf(_month) + 1).toString().padLeft(2, '0')}' + '-' + _day);

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    print('Formatted date: $formattedDate');
    setState(() {
      _callback(formattedDate);
    });
  }
}
