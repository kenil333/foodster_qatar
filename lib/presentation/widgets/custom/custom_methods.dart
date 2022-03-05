import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

appbarpref(bool dark, Color color) {
  return PreferredSize(
    child: AppBar(
      backgroundColor: color,
      systemOverlayStyle:
          dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      elevation: 0,
    ),
    preferredSize: const Size.fromHeight(0),
  );
}

routepushreplash(BuildContext context, Widget widget) {
  return Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

routepush(BuildContext context, Widget widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

snack(String title, String message, bool red) {
  return Get.snackbar(
    title,
    message,
    colorText: whit,
    backgroundColor: red ? redcolor : greencol,
    snackPosition: SnackPosition.BOTTOM,
  );
}

loadingwidget() {
  return const Center(
    child: SpinKitSpinningLines(
      color: primarycol,
    ),
  );
}

nodatafound(String title, Size size) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(dnfimage, width: 250, fit: BoxFit.contain),
      const SizedBox(height: 20),
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: redcolor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
