import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class CustomTextInput extends StatefulWidget {

  final AutovalidateMode autovalidateMode;
  final TextEditingController controller;
  final String hintText;
  final Widget icon;
  final TextInputType keyboardType;
  final Widget suffix;

  const CustomTextInput({
    Key key,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.controller,
    this.hintText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.suffix,
  }) : super(key: key);

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      autovalidateMode: AutovalidateMode.disabled,
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: PRIMARY_BLUE, width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: PRIMARY_BLUE, width: 2.0),
        ),
        hintStyle: hintStyle(),
        hintText: 'Email',
        icon: widget.icon,
        suffix: widget.suffix,
      ),
      keyboardType: TextInputType.emailAddress,
      style: bodyStyle(),
      validator: (_) {
        // return !state.isEmailValid ? 'Invalid Email' : null;
        return 'Invalid Email';
      },
    );
  }
}
