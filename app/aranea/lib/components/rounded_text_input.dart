import 'dart:async';
import 'dart:ffi';

import 'package:Aranea/constants.dart';
import 'package:flutter/material.dart';

class RoundedTextInput extends StatelessWidget {
  final Color color, textColor;
  final String textHint;
  final IconData icon;
  final TextEditingController controller;
  final num width;
  final bool password;
  final ValueChanged<String> onChanged;

  const RoundedTextInput({
    Key key,
    this.color = kPrimaryLightColor,
    this.textColor = kPrimaryDarkColor,
    this.width = 0.8,
    this.textHint = "Your Text Here",
    this.icon = Icons.sms,
    this.onChanged,
    this.password = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: controller,
        obscureText: password,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: textColor,
            ),
            hintText: textHint,
            hintStyle: TextStyle(color: textColor)),
      ),
    );
  }
}
