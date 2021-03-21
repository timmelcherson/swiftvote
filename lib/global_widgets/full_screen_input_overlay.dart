import 'package:flutter/material.dart';
import 'package:swiftvote/global_widgets/buttons/custom_outlined_button.dart';
import 'package:swiftvote/themes/themes.dart';

class FullScreenInputOverlay extends StatefulWidget {

  final String buttonText;
  final Function callback;

  FullScreenInputOverlay({@required this.buttonText, @required this.callback});

  @override
  _FullScreenInputOverlayState createState() => _FullScreenInputOverlayState();
}

class _FullScreenInputOverlayState extends State<FullScreenInputOverlay> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DEEP_BLUE_BG,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.transparent,
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  splashColor: LIGHT_BLUE,
                  splashRadius: 20.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              TextField(
                controller: _controller,
                maxLines: null,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: 'Write your comment...',
                  hintStyle: hintStyle(),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GRAY)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CustomOutlinedButton(
              buttonText: widget.buttonText,
              onPressFunction: () {
                print('unfocus');
                FocusScope.of(context).unfocus();
                widget.callback(_controller.value.text);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
