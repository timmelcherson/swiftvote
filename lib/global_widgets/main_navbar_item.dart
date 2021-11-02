import 'package:flutter/material.dart';
import 'package:swiftvote/themes/color_themes.dart';

class MainNavbarItem extends StatelessWidget {
  final bool isActive;
  final Function onTapCallback;
  final String iconPath;
  final IconData iconData;
  final String tag;

  // final double iconPadding;
  // final Color iconColor;

  MainNavbarItem({
    required this.isActive,
    required this.onTapCallback,
    required this.iconPath,
    required this.iconData,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {

    print("Tag ${this.tag} is active: ${this.isActive}");

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('callbnack');
            onTapCallback();
          },
          splashColor: Colors.white38,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.all(isActive ? 18.0 : 22.0),
            child: Icon(Icons.home, size: 20.0, color: Colors.white),
            // SvgPicture.asset(
            //   iconPath,
            //   color: isActive ? Colors.white : LIGHT_GRAY,
            // ),
          ),
        ),
      ),
    );
  }
}
