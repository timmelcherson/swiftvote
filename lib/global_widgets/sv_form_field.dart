import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class SvFormField extends StatelessWidget {

  final TextEditingController? controller;
  final String? hint;
  final TextStyle? textStyle;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;

  const SvFormField({
    this.controller,
    this.hint,
    this.textStyle,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        autocorrect: false,
        autovalidateMode: autovalidateMode,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: textStyle ?? hintStyle(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        ),
        keyboardType: keyboardType,
        style: bodyStyle(color: DARK_GRAY),
        // validator: (_) {
        //   return !state.isEmailValid ? 'Invalid Email' : null;
        // },
      ),
    );
  }
}
