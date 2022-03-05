import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class ResturentStemp extends StatelessWidget {
  final Size size;
  final ResturantModel resto;
  final Function onclick;
  const ResturentStemp({
    Key? key,
    required this.size,
    required this.resto,
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
        color: whit,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            SizedBox(
              height: size.width * 0.3,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: resto.restopic.length,
                itemBuilder: (context, i) => Container(
                  margin: EdgeInsets.only(
                    left: i == 0 ? 10 : 5,
                    right: i == 4 ? 10 : 5,
                  ),
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomNetworkImage(image: resto.restopic[i]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => Row(
                children: [
                  SizedBox(width: size.width * 0.04),
                  _globalcache.selectedlanguage.value == englishlangstr
                      ? Container()
                      : Expanded(child: Container()),
                  _globalcache.selectedlanguage.value == englishlangstr
                      ? SizedBox(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                                CustomNetworkImage(image: resto.profilepic[0]),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resto.name[_globalcache.selectedlanguage.value],
                              style: TextStyle(
                                fontSize: size.width * 0.042,
                                color: txtcol,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              resto.type[_globalcache.selectedlanguage.value],
                              style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: grycol,
                              ),
                            ),
                          ],
                        ),
                  SizedBox(width: size.width * 0.03),
                  _globalcache.selectedlanguage.value == englishlangstr
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resto.name[_globalcache.selectedlanguage.value],
                              style: TextStyle(
                                fontSize: size.width * 0.042,
                                color: txtcol,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              resto.type[_globalcache.selectedlanguage.value],
                              style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: grycol,
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                                CustomNetworkImage(image: resto.profilepic[0]),
                          ),
                        ),
                  _globalcache.selectedlanguage.value == englishlangstr
                      ? Expanded(child: Container())
                      : Container(),
                  SizedBox(width: size.width * 0.04),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
