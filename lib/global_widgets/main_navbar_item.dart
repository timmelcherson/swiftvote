import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainNavbarItem extends StatelessWidget {
  final bool isActive;
  final Function onTapCallback;
  final String iconPath;
  final String tag;
  // final double iconPadding;
  // final Color iconColor;

  MainNavbarItem({
    this.isActive,
    this.onTapCallback,
    this.iconPath,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTapCallback,
        splashColor: Colors.white38,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(vertical: isActive ? 12.0 : 16.0),
          child: Hero(
            tag: tag,
            child: Icon(Icons.home),
            // child: SvgPicture.asset(
            //   iconPath,
            //   height: 18.0,
            //   color: isActive ? Colors.[200] : null,
            // ),
          ),
        ),
      ),
    );
  }
}
