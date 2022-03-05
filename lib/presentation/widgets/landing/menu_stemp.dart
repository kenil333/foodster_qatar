import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class MenuStemp extends StatelessWidget {
  final Size size;
  final DishModel dish;
  final Function onclick;
  const MenuStemp({
    Key? key,
    required this.size,
    required this.dish,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    return GestureDetector(
      onTap: () {
        onclick();
      },
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomNetworkImage(image: dish.images[0]),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              dish.name[_globalcache.selectedlanguage.value],
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: size.width * 0.042,
                color: txtcol,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
