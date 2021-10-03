import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class CustomButton extends StatelessWidget {
  final Alignment buttonAlignment;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final VoidCallback onPress;
  final EdgeInsets margin;
  final bool submittable;
  final Widget leadingIcon;
  final Widget trailingIcon;

  const CustomButton({
    this.buttonAlignment,
    this.buttonText,
    this.buttonTextStyle,
    this.width,
    this.height = 48.0,
    this.borderRadius = 8.0,
    this.margin = const EdgeInsets.all(16.0),
    this.backgroundColor = PRIMARY_BG,
    this.onPress,
    this.submittable = true,
    this.leadingIcon,
    this.trailingIcon,
  });

  Color getOverlayColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.contains(MaterialState.disabled)) {
      return Colors.grey;
    }
    if (states.any(interactiveStates.contains)) {
      return LIGHT_BLUE.withOpacity(0.3);
    }
    return backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: buttonAlignment ?? Alignment.center,
      height: height,
      margin: margin,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: MaterialStateProperty.resolveWith(getOverlayColor),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(width ?? MediaQuery.of(context).size.width, height),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: submittable ? onPress : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: leadingIcon,
                  ),
                Text(buttonText, style: buttonTextStyle ?? buttonStyle(color: DARK_GRAY)),
              ],
            ),
            if (trailingIcon != null)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: trailingIcon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
