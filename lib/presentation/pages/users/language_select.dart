import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        backgroundColor: primarycol,
        title: Text(
          _globalcache
              .appstringrx[0].string[_globalcache.selectedlanguage.value]!,
          style: const TextStyle(
            fontFamily: secondaryfontfamily,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          SigninImgWid(size: size),
          const SizedBox(height: 50),
          CustomButton(
            size: size,
            title: englishlangstr,
            func: () async {
              final SharedPreferences _pref =
                  await SharedPreferences.getInstance();
              await _pref.setString("Language", englishlangstr);
              _globalcache.changeselectedlanguage(englishlangstr);
              routepush(context, const SignupScreen());
            },
          ),
          const SizedBox(height: 40),
          CustomButton(
            size: size,
            title: stringarabicstr,
            func: () async {
              // final _hour = DateFormat("h").format(DateTime.now());
              // final _minut = DateFormat("m").format(DateTime.now());
              // await NotificationService().schedulenotification(
              //   5,
              //   "Testing Notification",
              //   "Click to open the app for new quotes.",
              //   _hour,
              //   (int.parse(_minut) + 2).toString().length == 1
              //       ? "0${(int.parse(_minut) + 2).toString()}"
              //       : (int.parse(_minut) + 2).toString(),
              //   "PM",
              // );
              final SharedPreferences _pref =
                  await SharedPreferences.getInstance();
              await _pref.setString("Language", arabiclangstr);
              _globalcache.changeselectedlanguage(arabiclangstr);
              routepush(context, const SignupScreen());
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
