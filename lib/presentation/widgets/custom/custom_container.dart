import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomContainer extends StatelessWidget {
  final Size size;
  final String containervalue;
  final String language;
  const CustomContainer({
    Key? key,
    required this.size,
    required this.containervalue,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: 15,
      ),
      decoration: containerdeco,
      child: Row(
        children: [
          language == englishlangstr
              ? Container()
              : Expanded(child: Container()),
          Text(
            containervalue,
            style: TextStyle(
              fontSize: size.width * 0.05,
              color: txtcol,
              fontWeight: FontWeight.w500,
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
