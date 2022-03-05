import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import './../../../../domain/all.dart';

class BookmarksPage extends StatefulWidget {
  final Size size;
  const BookmarksPage({Key? key, required this.size}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabcontroller;
  final _globalcache = Get.put(GlobalCache());

  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: widget.size.width,
          height: widget.size.height * 0.06,
          padding: const EdgeInsets.only(bottom: 6),
          color: primarycol,
          child: Stack(
            children: [
              SizedBox(
                width: widget.size.width,
                child: Image.asset(
                  dashbordwhitimg,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: widget.size.width,
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Obx(
                                () => FilterDilog(
                                  size: widget.size,
                                  title: selectoptionstr[
                                      _globalcache.selectedlanguage.value]!,
                                  filterlits: [
                                    dataddedstr[
                                        _globalcache.selectedlanguage.value]!,
                                    atozstr[
                                        _globalcache.selectedlanguage.value]!,
                                  ],
                                  initialvalue: _globalcache.selbookmark.value,
                                  onok: (String selected) {
                                    _globalcache.changeselbookmark(selected);
                                    if (selected ==
                                        dataddedstr[_globalcache
                                            .selectedlanguage.value]!) {
                                      if (_globalcache.favrestolistrx.length >
                                          1) {
                                        _globalcache.favrestolistrx.sort(
                                          (a, b) => a.date.compareTo(b.date),
                                        );
                                      }
                                      if (_globalcache.favdishlistrx.length >
                                          1) {
                                        _globalcache.favdishlistrx.sort(
                                          (a, b) => a.date.compareTo(b.date),
                                        );
                                      }
                                    } else {
                                      if (_globalcache.favrestolistrx.length >
                                          1) {
                                        _globalcache.favrestolistrx.sort(
                                          (a, b) => a.name.compareTo(b.name),
                                        );
                                      }
                                      if (_globalcache.favdishlistrx.length >
                                          1) {
                                        _globalcache.favdishlistrx.sort(
                                          (a, b) => a.name.compareTo(b.name),
                                        );
                                      }
                                    }
                                  },
                                  btntxt: okstr[
                                      _globalcache.selectedlanguage.value]!,
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.sort,
                            size: 25,
                            color: whit,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: widget.size.width * 0.05),
          child: Stack(
            children: [
              TabBar(
                controller: _tabcontroller,
                indicatorColor: primarycol,
                labelColor: txtcol,
                indicatorWeight: 3,
                labelStyle: TextStyle(
                  fontSize: widget.size.width * 0.042,
                  fontWeight: FontWeight.bold,
                  color: txtcol,
                ),
                unselectedLabelStyle: TextStyle(
                  color: txtcol,
                  fontSize: widget.size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
                tabs: [
                  Tab(
                    text: restaurantsstr[_globalcache.selectedlanguage.value],
                  ),
                  Tab(
                    text: dishstr[_globalcache.selectedlanguage.value],
                  ),
                ],
              ),
              Positioned(
                bottom: 1,
                child: Container(
                  width: widget.size.width,
                  height: 0.5,
                  color: primarycol,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabcontroller,
            children: [
              Obx(
                () => _globalcache.favrestolistrx.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _globalcache.favrestolistrx.length,
                        itemBuilder: (context, i) =>
                            (_globalcache.resturantlistrx.any((element) =>
                                    element.id ==
                                    _globalcache.favrestolistrx[i].id))
                                ? ResturentStemp(
                                    size: size,
                                    resto: _globalcache.fetchrestomodel(
                                      _globalcache.favrestolistrx[i].id,
                                    ),
                                    onclick: () {
                                      pushNewScreen(
                                        context,
                                        screen: DetailScreen(
                                          resto: _globalcache.fetchrestomodel(
                                            _globalcache.favrestolistrx[i].id,
                                          ),
                                        ),
                                        withNavBar: false,
                                      );
                                    },
                                  )
                                : Container(),
                      )
                    : nodatafound(
                        norestobookmarksstr[
                            _globalcache.selectedlanguage.value]!,
                        size),
              ),
              Obx(
                () => _globalcache.favdishlistrx.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _globalcache.favdishlistrx.length,
                        itemBuilder: (context, i) => (_globalcache.dishlistrx
                                .any((element) =>
                                    element.id ==
                                    _globalcache.favdishlistrx[i].id))
                            ? DishStemp(
                                size: size,
                                dish: _globalcache.fetchdishmodel(
                                  _globalcache.favdishlistrx[i].id,
                                ),
                                onclick: () {
                                  pushNewScreen(
                                    context,
                                    screen: DishDetailScreen(
                                      dish: _globalcache.fetchdishmodel(
                                        _globalcache.favdishlistrx[i].id,
                                      ),
                                    ),
                                    withNavBar: false,
                                  );
                                },
                              )
                            : Container(),
                      )
                    : nodatafound(
                        nodishbookmarksstr[
                            _globalcache.selectedlanguage.value]!,
                        size),
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     padding: EdgeInsets.zero,
        //     itemCount: 7,
        //     itemBuilder: (context, i) => ResturentStemp(
        //       size: size,
        //       onclick: () {},
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
