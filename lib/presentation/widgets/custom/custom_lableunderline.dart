import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class CustomLableUnderline extends StatelessWidget {
  final Size size;
  final String title;
  const CustomLableUnderline({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              _globalcache.selectedlanguage.value == englishlangstr
                  ? Container()
                  : Expanded(child: Container()),
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.048,
                  color: txtcol,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _globalcache.selectedlanguage.value == englishlangstr
                  ? Expanded(child: Container())
                  : Container(),
            ],
          ),
        ),
        const SizedBox(height: 1),
        Obx(
          () => Row(
            children: [
              _globalcache.selectedlanguage.value == englishlangstr
                  ? Container()
                  : Expanded(child: Container()),
              Container(
                width: size.width * 0.13,
                height: 2,
                color: primarycol,
              ),
              _globalcache.selectedlanguage.value == englishlangstr
                  ? Expanded(child: Container())
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
