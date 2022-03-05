import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class TitlePriceTag extends StatelessWidget {
  final Size size;
  final DishModel dish;
  const TitlePriceTag({
    Key? key,
    required this.size,
    required this.dish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name[_globalcache.selectedlanguage.value],
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: txtcol,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _globalcache.fetchrestoname(dish.restoid),
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: grycol,
                  ),
                ),
              ],
            ),
          ),
          CustomSmallbtn(
            size: size,
            title: "QAR ${dish.price.toStringAsFixed(0)}",
            open: false,
          ),
          // CustomPriceTag(size: size, price: "QAR 35"),
        ],
      ),
    );
  }
}
