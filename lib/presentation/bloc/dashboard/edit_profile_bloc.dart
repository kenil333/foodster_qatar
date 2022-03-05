import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class EditProfileBloc {
  final TextEditingController namecont = TextEditingController();
  final TextEditingController phonecont = TextEditingController();
  final TextEditingController emailcont = TextEditingController();
  final loading = BoolStream();

  updateprofile(
    String id,
    String name,
    String phone,
    String email,
    Function setcache,
  ) async {
    loading.sink.add(true);
    await FirebaseHelper.updateprofilefire(
      id,
      namecont.text.isEmpty ? name : namecont.text,
      phonecont.text.isEmpty ? phone : phonecont.text,
      emailcont.text.isEmpty ? email : emailcont.text,
    );
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString(
      "Name",
      namecont.text.isEmpty ? name : namecont.text,
    );
    await _pref.setString(
      "Phone",
      phonecont.text.isEmpty ? phone : phonecont.text,
    );
    setcache(
      namecont.text.isEmpty ? name : namecont.text,
      phonecont.text.isEmpty ? phone : phonecont.text,
      emailcont.text.isEmpty ? email : emailcont.text,
    );
    loading.sink.add(false);
    Get.back();
  }
}
