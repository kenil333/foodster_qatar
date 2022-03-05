import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomButton extends StatelessWidget {
  final Size size;
  final String title;
  final Function func;
  const CustomButton({
    Key? key,
    required this.size,
    required this.title,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: primarycol,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: () {
          func();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
          child: Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.05,
              fontFamily: secondaryfontfamily,
            ),
          ),
        ),
      ),
    );
  }
}
