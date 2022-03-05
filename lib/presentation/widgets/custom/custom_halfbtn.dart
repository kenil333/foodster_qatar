import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class CustomHalfButon extends StatelessWidget {
  final Size size;
  final String title;
  final Function onclick;
  const CustomHalfButon({
    Key? key,
    required this.size,
    required this.title,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    return GestureDetector(
      onTap: () {
        onclick();
      },
      child: Container(
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: title == _globalcache.selectedlanguage.value
              ? primarycol
              : primarycol.withOpacity(0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          title == arabiclangstr ? stringarabicstr : title,
          style: TextStyle(
            fontSize: size.width * 0.045,
            fontFamily: secondaryfontfamily,
            color: title == _globalcache.selectedlanguage.value
                ? whit
                : primarycol,
          ),
        ),
      ),
    );
  }
}
