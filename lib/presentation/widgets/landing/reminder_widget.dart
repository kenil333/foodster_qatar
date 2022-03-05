import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class ReminderWidget extends StatelessWidget {
  final Size size;
  final String title;
  final bool initialbool;
  final Function onclick;
  const ReminderWidget({
    Key? key,
    required this.size,
    required this.title,
    required this.initialbool,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: 10,
      ),
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.03,
        top: 10,
        bottom: 10,
      ),
      decoration: containerdeco,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.05,
              color: txtcol,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(child: Container()),
          Switch(
            value: initialbool,
            activeColor: primarycol,
            onChanged: (bool value) {
              onclick(value);
            },
          ),
          SizedBox(width: size.width * 0.01),
        ],
      ),
    );
  }
}
