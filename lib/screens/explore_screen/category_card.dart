import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  CategoryCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: LIGHT_GRAY,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80.0,
          ),
          Text(
            title,
            style: bodyStyle(color: CHARCOAL_GRAY),
          ),
        ],
      ),
    );
  }
}
