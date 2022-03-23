import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _bloc = SplashBloc();
  final _globalcache = Get.put(GlobalCache());

  // getpermission(Function forward) async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     LocationPermission _permission = await Geolocator.requestPermission();
  //     if (_permission == LocationPermission.denied) {
  //       getpermission(forward);
  //     } else if (permission == LocationPermission.deniedForever) {
  //       await Geolocator.openLocationSettings();
  //       getpermission(forward);
  //     } else {
  //       await Geolocator.getCurrentPosition().then((Position position) {
  //         _globalcache.changelatlong(position.latitude, position.longitude);
  //         forward();
  //       });
  //     }
  //   } else if (permission == LocationPermission.deniedForever) {
  //     await Geolocator.openLocationSettings();
  //     getpermission(forward);
  //   } else {
  //     await Geolocator.getCurrentPosition().then((Position position) {
  //       _globalcache.changelatlong(position.latitude, position.longitude);
  //       forward();
  //     });
  //   }
  // }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) async {
      // getpermission(() {
      _globalcache.changeappstring(await FirebaseHelper.getappstrings());
      _bloc.autologin(
        () {
          routepushreplash(context, const BottomBar());
        },
        () {
          routepushreplash(context, const LanguageSelectScreen());
        },
        () async {
          await _globalcache.fetchbookmarks();
          _globalcache.changeapplink(
            await FirebaseHelper.getandroidioslink(),
          );
        },
        (String id, String name, String email, String phone) {
          _globalcache.changeuserdata(id, name, email, phone);
        },
        (String choosedlang) {
          _globalcache.changeselectedlanguage(choosedlang);
          _globalcache.changesearchoprx(
            _globalcache
                .appstringrx[8].string[_globalcache.selectedlanguage.value]!,
          );
        },
        () {
          _globalcache.changegeust(true);
        },
      );
      // });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double toppad = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: screenback,
      appBar: appbarpref(false, primarycol),
      body: Container(
        padding: EdgeInsets.only(bottom: toppad),
        width: size.width,
        height: size.height,
        color: primarycol,
        child: Center(
          child: Image.asset(
            splashiconimg,
            width: size.width * 0.9,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
