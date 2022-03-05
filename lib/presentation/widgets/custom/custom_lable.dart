import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomLable extends StatelessWidget {
  final Size size;
  final String title;
  final String language;
  const CustomLable({
    Key? key,
    required this.size,
    required this.title,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          language == englishlangstr
              ? Container()
              : Expanded(child: Container()),
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.05,
              color: txtcol,
              fontWeight: FontWeight.bold,
            ),
          ),
          language == englishlangstr
              ? Expanded(child: Container())
              : Container(),
        ],
      ),
    );
  }
}
