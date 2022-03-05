import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class DishStemp extends StatelessWidget {
  final Size size;
  final DishModel dish;
  final Function onclick;
  const DishStemp({
    Key? key,
    required this.size,
    required this.dish,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () {
          onclick();
        },
        child: Container(
          color: whit,
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.3,
                width: size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dish.images.length,
                  itemBuilder: (context, i) => Container(
                    margin: EdgeInsets.only(
                      left: i == 0 ? 10 : 5,
                      right: i == (dish.images.length - 1) ? 10 : 5,
                    ),
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomNetworkImage(image: dish.images[i]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TitlePriceTag(size: size, dish: dish),
            ],
          ),
        ),
      ),
    );
  }
}
