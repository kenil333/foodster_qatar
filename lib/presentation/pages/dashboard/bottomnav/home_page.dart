import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import './../../../../domain/all.dart';

class HomePage extends StatelessWidget {
  final Size size;
  const HomePage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.06,
          padding: const EdgeInsets.only(bottom: 6),
          color: primarycol,
          alignment: Alignment.center,
          child: Image.asset(
            dashbordwhitimg,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 6),
                StreamBuilder(
                  stream: FirebaseHelper.bannerstream(),
                  builder: (context, bannersnap) {
                    if (bannersnap.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: double.infinity,
                        height: size.height * 0.3,
                        child: loadingwidget(),
                      );
                    } else if ((bannersnap.data as DatabaseEvent)
                                .snapshot
                                .value !=
                            null &&
                        bannersnap.hasData &&
                        !bannersnap.hasError) {
                      List<BannerModel> _list = [];
                      final Map _data = ((bannersnap.data as DatabaseEvent)
                          .snapshot
                          .value as Map);
                      _data.forEach((key, value) {
                        final _todaydate = DateTime.parse(
                          DateFormat("yyyyMMdd").format(DateTime.now()),
                        );
                        final _start =
                            DateTime.parse(value["StartDate"]).subtract(
                          const Duration(days: 1),
                        );
                        final _end = DateTime.parse(value["EndDate"]).add(
                          const Duration(days: 1),
                        );
                        if (_start.isBefore(_todaydate) &&
                            _end.isAfter(_todaydate)) {
                          _list.add(BannerModel.fromfire(key, value));
                        }
                      });
                      return SliderWidget(size: size, banners: _list);
                    } else {
                      return SizedBox(
                        width: double.infinity,
                        height: size.height * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              color: redcolor,
                              size: size.width * 0.2,
                            ),
                            const SizedBox(height: 20),
                            Obx(
                              () => Text(
                                _globalcache.appstringrx[39].string[
                                    _globalcache.selectedlanguage.value]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  color: redcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                _globalcache.resturantlistrx.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: _globalcache.resturantlistrx.length,
                        itemBuilder: (context, i) => ResturentStemp(
                          size: size,
                          resto: _globalcache.resturantlistrx[i],
                          onclick: () {
                            pushNewScreen(
                              context,
                              screen: DetailScreen(
                                resto: _globalcache.resturantlistrx[i],
                              ),
                              withNavBar: false,
                            );
                          },
                        ),
                      )
                    : Obx(
                        () => nodatafound(
                            _globalcache.appstringrx[40]
                                .string[_globalcache.selectedlanguage.value]!,
                            size),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
