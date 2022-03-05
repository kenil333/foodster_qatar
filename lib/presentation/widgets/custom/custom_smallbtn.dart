import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomSmallbtn extends StatelessWidget {
  final Size size;
  final String title;
  final bool open;
  const CustomSmallbtn({
    Key? key,
    required this.size,
    required this.title,
    required this.open,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     elevation: 2,
        //     primary:
        //         open ? greencol.withOpacity(0.2) : secondarycol.withOpacity(0.2),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(100),
        //     ),
        //   ),
        //   onPressed: () {
        //     func();
        //   },
        //   child:
        Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: open ? greencol.withOpacity(0.2) : primarycol.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: open ? greencol : primarycol,
          fontSize: size.width * 0.04,
          fontFamily: secondaryfontfamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      //),
    );
  }
}
