import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CateLable extends StatelessWidget {
  final Size size;
  final String title;
  const CateLable({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.25,
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: grycol.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: TextStyle(
          fontSize: size.width * 0.035,
          color: txtcol,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
