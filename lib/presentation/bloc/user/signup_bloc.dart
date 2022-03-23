import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class SingupBloc {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final loading = BoolStream();

  signup(Function forward, Function setcache) async {
    loading.sink.add(true);
    if (name.text.isEmpty) {
      snack("Alert !", "Please Insert Name !", true);
      loading.sink.add(false);
    } else if (phone.text.isEmpty) {
      snack("Alert !", "Please Insert Phone Number !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.signupfire(
        name.text,
        phone.text,
        email.text.isEmpty ? "null" : email.text,
        DateFormat("yyyyMMdd").format(DateTime.now()),
        setcache,
      ).then((bool success) async {
        if (!success) {
          snack("Alert !", "This Phone number already in Use !", true);
          loading.sink.add(false);
        } else {
          final SharedPreferences _pref = await SharedPreferences.getInstance();
          await _pref.setString("Name", name.text);
          await _pref.setString("Phone", phone.text);
          await _pref.setBool("Guest", false);
          loading.sink.add(false);
          forward();
        }
      });
    }
  }
}
