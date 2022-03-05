import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomTextfeild extends StatelessWidget {
  final Size size;
  final String hintstr;
  final TextEditingController controller;
  final bool number;
  final String language;
  final bool enable;
  const CustomTextfeild({
    Key? key,
    required this.size,
    required this.hintstr,
    required this.controller,
    this.number = false,
    required this.language,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.01,
        horizontal: size.width * 0.045,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: 10,
      ),
      decoration: containerdeco,
      child: TextField(
        keyboardType:
            number ? TextInputType.number : TextInputType.emailAddress,
        textAlign: language == englishlangstr ? TextAlign.start : TextAlign.end,
        obscureText: false,
        enabled: enable,
        controller: controller,
        style: TextStyle(
          fontSize: size.width * 0.045,
          color: txtcol,
        ),
        decoration: InputDecoration(
          hintText: hintstr,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
