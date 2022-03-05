import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomTextsendBtn extends StatelessWidget {
  final Size size;
  final String title;
  final bool border;
  final Function onclick;
  const CustomTextsendBtn({
    Key? key,
    required this.size,
    required this.title,
    required this.border,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onclick();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: border ? 0.5 : 0,
              color: border ? txtcol : whit,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.048,
                color: txtcol,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: txtcol,
              size: size.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
