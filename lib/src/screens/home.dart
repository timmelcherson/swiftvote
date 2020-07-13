import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/src/widgets/placeholder_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  final Con _con = Con.con;
  int _currentIndex = 2;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.cyan),
    PlaceholderWidget(Colors.yellowAccent)
  ];

//  @override
//  void initState() {
//    super.initState();
//
//    /// Calls the Controller when this one-time 'init' event occurs.
//    /// Not revealing the 'business logic' that then fires inside.
////    _con.init();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        onTap: onNavigationTap,
        currentIndex: _currentIndex,
        elevation: 0.0,
//        selectedItemColor: Colors.cyan[700],
//        unselectedItemColor: Color.fromRGBO(80, 92, 116, 1),
//        selectedFontSize: 12.0,
        selectedIconTheme: IconThemeData(
          size: 20.0,
          color: Colors.cyan[700],
        ),
        unselectedIconTheme: IconThemeData(
          size: 20.0,
          color: Color.fromRGBO(80, 92, 116, 1),
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
              ),
              title: Text('Explore')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text('Search')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              title: Text('Notifications')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart,
              ),
              title: Text('Stats')),
        ],
      ),
      body: _children[_currentIndex],
    );
  }

  void onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
