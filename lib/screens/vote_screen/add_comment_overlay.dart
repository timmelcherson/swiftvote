import 'package:flutter/material.dart';
import 'package:swiftvote/global_widgets/buttons/custom_outlined_button.dart';
import 'package:swiftvote/global_widgets/full_screen_input_overlay.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class AddCommentOverlay extends ModalRoute<void> {
  final Function callback;

  AddCommentOverlay({required this.callback});

  @override
  Color get barrierColor => Colors.white;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Scaffold(
      body: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return FullScreenInputOverlay(buttonText: 'Add Comment', callback: callback);
  }
}
