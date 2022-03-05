import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CategoryStemp extends StatelessWidget {
  final Size size;
  final String title;
  final String image;
  final int index;
  final Function onclick;
  const CategoryStemp({
    Key? key,
    required this.size,
    required this.title,
    required this.image,
    required this.index,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: index == 0 ? 15 : 0,
        bottom: 20,
      ),
      child: GestureDetector(
        onTap: () {
          onclick();
        },
        child: Container(
          width: double.infinity,
          height: size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomNetworkImage(image: image),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: whit,
                  ),
                ),
              ),
              // Column(
              //   children: [
              //     Expanded(child: Container()),
              //     ((count % 2) == 0)
              //         ? Row(
              //             children: [
              //               Expanded(child: Container()),
              //               Text(
              //                 title,
              //                 style: TextStyle(
              //                   fontSize: size.width * 0.06,
              //                   fontWeight: FontWeight.bold,
              //                   color: whit,
              //                 ),
              //               ),
              //               SizedBox(width: size.width * 0.32),
              //             ],
              //           )
              //         : Row(
              //             children: [
              //               SizedBox(width: size.width * 0.32),
              //               Text(
              //                 title,
              //                 style: TextStyle(
              //                   fontSize: size.width * 0.06,
              //                   fontWeight: FontWeight.bold,
              //                   color: whit,
              //                 ),
              //               ),
              //               Expanded(child: Container()),
              //             ],
              //           ),
              //     Expanded(child: Container()),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
