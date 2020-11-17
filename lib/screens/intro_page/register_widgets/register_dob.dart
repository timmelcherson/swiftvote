import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swiftvote/themes/themes.dart';

class RegisterDob extends StatefulWidget {
  @override
  State createState() => _RegisterDobState();
}

class _RegisterDobState extends State<RegisterDob> {
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
  final List<String> years = List.generate(100, (index) => '${1920 + index}');

  String _day;
  String _month;
  String _year;
  DateTime _fullDate;

  @override
  void initState() {
    super.initState();
    _day = days[0];
    _month = months[0];
    _year = years[0];
  }

  @override
  Widget build(BuildContext context) {
    print(_day);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 48.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Date of Birth',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Day',
              style: TextThemes.mediumGrayTextStyle,
            ),
            DropdownButton<String>(
              value: _day,
              style: TextThemes.smallDarkTextStyle,
              onChanged: (value) {
                setState(() {
                  _day = value;
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
              style: TextThemes.mediumGrayTextStyle,
            ),
            DropdownButton<String>(
              value: _month,
              style: TextThemes.smallDarkTextStyle,
              onChanged: (value) {
                setState(() {
                  _month = value;
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
              style: TextThemes.mediumGrayTextStyle,
            ),
            DropdownButton<String>(
              value: _year,
              style: TextThemes.smallDarkTextStyle,
              onChanged: (value) {
                setState(() {
                  _year = value;
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
    );
  }

  void setDate() {
    DateTime date = DateTime.parse(
        _year + '-' + '${(months.indexOf(_month) + 1).toString().padLeft(2, '0')}' + '-' + _day);
    print(date);
    setState(() {
      _fullDate = date;
    });
  }
}
