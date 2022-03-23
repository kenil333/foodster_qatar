import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import './../../../../domain/all.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PersistentTabController? _controller;
  final _globalcache = Get.put(GlobalCache());
  final _loading = BoolStream();

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    Future.delayed(const Duration(seconds: 0)).then(
      (_) async {
        await FirebaseHelper.setalldata(
          (List<ResturantModel> restolist) {
            _globalcache.changerestolist(restolist);
          },
          (List<DishModel> dishlist) {
            _globalcache.changedishlist(dishlist);
          },
          (List<CategoryModel> catelist, List<TagModel> taglist) {
            _globalcache.changecategorylist(catelist);
            _globalcache.changetaglist(taglist);
          },
        );
        _loading.sink.add(false);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<Widget> _screensofbar(Size size) {
      return [
        HomePage(size: size),
        CategoriesPage(size: size),
        BookmarksPage(size: size),
        SearchPage(size: size),
        ProfilePage(size: size),
      ];
    }

    return Scaffold(
      backgroundColor: screenback,
      appBar: appbarpref(false, primarycol),
      body: StreamBuilder<bool>(
        stream: _loading.stream,
        initialData: true,
        builder: (context, loadingsnap) {
          if (loadingsnap.data!) {
            return loadingwidget();
          } else {
            return Obx(
              () => PersistentTabView(
                context,
                controller: _controller,
                screens: _screensofbar(size),
                items: [
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.home_rounded),
                    title: _globalcache.appstringrx[9]
                        .string[_globalcache.selectedlanguage.value]!,
                    activeColorPrimary: primarycol,
                    inactiveColorPrimary: grycol,
                  ),
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.menu_rounded),
                    title: _globalcache.appstringrx[10]
                        .string[_globalcache.selectedlanguage.value]!,
                    activeColorPrimary: primarycol,
                    inactiveColorPrimary: grycol,
                  ),
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.bookmark_border_rounded),
                    title: _globalcache.appstringrx[11]
                        .string[_globalcache.selectedlanguage.value]!,
                    activeColorPrimary: primarycol,
                    inactiveColorPrimary: grycol,
                  ),
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.search_rounded),
                    title: _globalcache.appstringrx[12]
                        .string[_globalcache.selectedlanguage.value]!,
                    activeColorPrimary: primarycol,
                    inactiveColorPrimary: grycol,
                  ),
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.person_outline_rounded),
                    title: _globalcache.appstringrx[13]
                        .string[_globalcache.selectedlanguage.value]!,
                    activeColorPrimary: primarycol,
                    inactiveColorPrimary: grycol,
                  ),
                ],
                confineInSafeArea: true,
                backgroundColor: whit,
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset: true,
                stateManagement: true,
                hideNavigationBarWhenKeyboardShows: true,
                decoration: const NavBarDecoration(
                  colorBehindNavBar: whit,
                  boxShadow: [
                    BoxShadow(
                      color: txtcol,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style9,
              ),
            );
          }
        },
      ),
    );
  }
}
