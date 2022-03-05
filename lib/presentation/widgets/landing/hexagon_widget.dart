import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class HaxagonWidget extends StatelessWidget {
  final Size size;
  final String title;
  final Function onclick;
  const HaxagonWidget({
    Key? key,
    required this.size,
    required this.title,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TriangleClipper(),
      child: GestureDetector(
        onTap: () {
          onclick();
        },
        child: Container(
          width: size.width * 0.3,
          height: size.width * 0.35,
          color: whit,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.04,
              color: txtcol,
              fontFamily: secondaryfontfamily,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.25);
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
