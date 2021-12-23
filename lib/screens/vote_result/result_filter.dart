import 'package:flutter/material.dart';

class ResultFilter extends StatefulWidget {
  const ResultFilter({Key? key}) : super(key: key);

  @override
  _ResultFilterState createState() => _ResultFilterState();
}

class _ResultFilterState extends State<ResultFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      color: Colors.green.withOpacity(0.3),
      child: Center(
        child: Text('Result Filter'),
      ),
    );
  }
}
