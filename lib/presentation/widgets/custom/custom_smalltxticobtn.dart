import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomSmallTexticonbtn extends StatelessWidget {
  final Size size;
  final String title;
  final IconData icon;
  final Function onclick;
  const CustomSmallTexticonbtn({
    Key? key,
    required this.size,
    required this.title,
    required this.icon,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onclick();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: primarycol,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: size.height * 0.012),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontFamily: secondaryfontfamily,
                  color: whit,
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Icon(icon, color: whit, size: size.width * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
