import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import './../../../../domain/all.dart';

class CategoriesPage extends StatefulWidget {
  final Size size;
  const CategoriesPage({Key? key, required this.size}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _globalcache = Get.put(GlobalCache());
  final _selcted = StringStream();

  @override
  void dispose() {
    _selcted.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> _category = [
    //   restaurantsstr[_globalcache.selectedlanguage.value]!,
    //   cafestr[_globalcache.selectedlanguage.value]!,
    //   dinnerstr[_globalcache.selectedlanguage.value]!,
    //   lunchstr[_globalcache.selectedlanguage.value]!,
    //   breakfaststr[_globalcache.selectedlanguage.value]!,
    //   dessertstr[_globalcache.selectedlanguage.value]!,
    //   snackstr[_globalcache.selectedlanguage.value]!,
    //   burgerstr[_globalcache.selectedlanguage.value]!,
    //   pizzastr[_globalcache.selectedlanguage.value]!,
    // ];
    return Column(
      children: [
        Container(
          width: widget.size.width,
          height: widget.size.height * 0.06,
          padding: const EdgeInsets.only(bottom: 6),
          color: primarycol,
          alignment: Alignment.center,
          child: Image.asset(
            dashbordwhitimg,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child:
              // SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       const SizedBox(height: 25),
              //       Stack(
              //         children: [
              //           Container(
              //             width: size.width,
              //             padding: EdgeInsets.only(top: size.width * 1.18),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 HaxagonWidget(
              //                   size: size,
              //                   title:
              //                       pizzastr[_globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Container(
              //             width: size.width,
              //             padding: EdgeInsets.only(top: size.width * 0.885),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 HaxagonWidget(
              //                   size: size,
              //                   title: dessertstr[
              //                       _globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //                 SizedBox(width: size.width * 0.03),
              //                 HaxagonWidget(
              //                   size: size,
              //                   title:
              //                       snackstr[_globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Container(
              //             width: size.width,
              //             padding: EdgeInsets.only(top: size.width * 0.59),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 HaxagonWidget(
              //                   size: size,
              //                   title:
              //                       cafestr[_globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //                 SizedBox(width: size.width * 0.03),
              //                 HaxagonWidget(
              //                   size: size,
              //                   title: restaurantsstr[
              //                       _globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //                 SizedBox(width: size.width * 0.03),
              //                 HaxagonWidget(
              //                   size: size,
              //                   title:
              //                       dinnerstr[_globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Container(
              //             width: size.width,
              //             padding: EdgeInsets.only(top: size.width * 0.295),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 HaxagonWidget(
              //                   size: size,
              //                   title:
              //                       lunchstr[_globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //                 SizedBox(width: size.width * 0.03),
              //                 HaxagonWidget(
              //                   size: size,
              //                   title: breakfaststr[
              //                       _globalcache.selectedlanguage.value]!,
              //                   onclick: () {
              //                     routepush(context, const BottomBar());
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               HaxagonWidget(
              //                 size: size,
              //                 title:
              //                     burgerstr[_globalcache.selectedlanguage.value]!,
              //                 onclick: () {
              //                   routepush(context, const BottomBar());
              //                 },
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 25),
              //     ],
              //   ),
              // ),
              SingleChildScrollView(
            child: StreamBuilder<String?>(
                stream: _selcted.stream,
                initialData: restaurantsstr[englishlangstr],
                builder: (context, selstrsnap) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: widget.size.width * 0.06,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: primarycol,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _selcted.sink
                                      .add(restaurantsstr[englishlangstr]!);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: selstrsnap.data ==
                                            restaurantsstr[englishlangstr]!
                                        ? primarycol
                                        : Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      restaurantsstr[englishlangstr]!,
                                      style: TextStyle(
                                        fontSize: widget.size.width * 0.038,
                                        color: selstrsnap.data ==
                                                restaurantsstr[englishlangstr]!
                                            ? whit
                                            : primarycol,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _selcted.sink.add(dishstr[englishlangstr]!);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: selstrsnap.data ==
                                            dishstr[englishlangstr]!
                                        ? primarycol
                                        : Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      dishstr[englishlangstr]!,
                                      style: TextStyle(
                                        fontSize: widget.size.width * 0.038,
                                        color: selstrsnap.data ==
                                                dishstr[englishlangstr]!
                                            ? whit
                                            : primarycol,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      selstrsnap.data == restaurantsstr[englishlangstr]
                          ? Obx(
                              () => _globalcache.caterestolistrx.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          _globalcache.caterestolistrx.length,
                                      itemBuilder: (context, i) => Obx(
                                        () => CategoryStemp(
                                          size: widget.size,
                                          title: _globalcache
                                                  .caterestolistrx[i].name[
                                              _globalcache
                                                  .selectedlanguage.value]!,
                                          image: _globalcache
                                              .caterestolistrx[i].image!,
                                          index: i,
                                          onclick: () {
                                            pushNewScreen(
                                              context,
                                              screen: CateRestolistScreen(
                                                  category: _globalcache
                                                      .caterestolistrx[i]),
                                              withNavBar: false,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : nodatafound(
                                      categorylistemptystr[
                                          _globalcache.selectedlanguage.value]!,
                                      widget.size),
                            )
                          : Obx(
                              () => _globalcache.catedishlistrx.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          _globalcache.catedishlistrx.length,
                                      itemBuilder: (context, i) => Obx(
                                        () => CategoryStemp(
                                          size: widget.size,
                                          title: _globalcache
                                                  .catedishlistrx[i].name[
                                              _globalcache
                                                  .selectedlanguage.value]!,
                                          image: _globalcache
                                              .catedishlistrx[i].image!,
                                          index: i,
                                          onclick: () {
                                            pushNewScreen(
                                              context,
                                              screen: CateDishListScren(
                                                  category: _globalcache
                                                      .catedishlistrx[i]),
                                              withNavBar: false,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : nodatafound(
                                      categorylistemptystr[
                                          _globalcache.selectedlanguage.value]!,
                                      widget.size),
                            ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}
