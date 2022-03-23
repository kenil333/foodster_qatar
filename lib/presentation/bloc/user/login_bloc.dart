import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class LoginBloc {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final loading = BoolStream();

  login(Function forward, Function setcache) async {
    loading.sink.add(true);
    if (name.text.isEmpty) {
      snack("Alert !", "Please Insert Name !", true);
      loading.sink.add(false);
    } else if (phone.text.isEmpty) {
      snack("Alert !", "Please Insert Phone Number !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.loginfire(name.text, phone.text, setcache).then(
        (String result) async {
          if (result == "Go") {
            final SharedPreferences _pref =
                await SharedPreferences.getInstance();
            await _pref.setString("Name", name.text);
            await _pref.setString("Phone", phone.text);
            await _pref.setBool("Guest", false);
            loading.sink.add(false);
            forward();
          } else {
            loading.sink.add(false);
            snack("Alert !", result, true);
          }
        },
      );
    }
  }
}
