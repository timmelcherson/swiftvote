import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    this.isActive,
    this.onTapCallback,
    this.iconPath,
    this.iconData,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {

    print("Tag ${this.tag} is active: ${this.isActive}");

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTapCallback,
          splashColor: Colors.white38,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.all(isActive ? 18.0 : 22.0),
            child: SvgPicture.asset(
              iconPath,
              color: isActive ? Colors.white : LIGHT_GRAY,
            ),
          ),
        ),
      ),
    );
  }
}
