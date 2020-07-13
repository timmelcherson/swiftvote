import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:swiftvote/src/screens/home.dart';
import 'package:swiftvote/src/controller.dart';

class App extends AppMVC {
//  App({Key key}) : super(con: _controller, key: key);

//  static final Con _controller = Con();

  static MaterialApp _app;

//  static String get title => _app.title.toString();

  @override
  Widget build(BuildContext context) {
    _app = MaterialApp(
      title: 'SwiftVote',
//      home: Home(),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    );
    return _app;
  }
}
