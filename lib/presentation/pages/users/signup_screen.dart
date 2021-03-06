import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _bloc = SingupBloc();
  final _globalcache = Get.put(GlobalCache());

  @override
  void dispose() {
    _bloc.loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        backgroundColor: primarycol,
        title: Text(
          _globalcache
              .appstringrx[5].string[_globalcache.selectedlanguage.value]!,
          style: const TextStyle(
            fontFamily: secondaryfontfamily,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                signiniconimg,
                fit: BoxFit.contain,
                width: size.width * 0.5,
              ),
            ),
            const SizedBox(height: 5),
            Stack(
              children: [
                CustomTextfeild(
                  size: size,
                  hintstr: _globalcache.appstringrx[2]
                      .string[_globalcache.selectedlanguage.value]!,
                  controller: _bloc.name,
                  language: _globalcache.selectedlanguage.value,
                ),
                Positioned(
                  top: 17,
                  right: size.width * 0.07,
                  child: Text(
                    "*",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: redcolor,
                      fontSize: size.width * 0.06,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Stack(
              children: [
                CustomTextfeild(
                  size: size,
                  hintstr: _globalcache.appstringrx[3]
                      .string[_globalcache.selectedlanguage.value]!,
                  controller: _bloc.phone,
                  language: _globalcache.selectedlanguage.value,
                  number: true,
                ),
                Positioned(
                  top: 17,
                  right: size.width * 0.07,
                  child: Text(
                    "*",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: redcolor,
                      fontSize: size.width * 0.06,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            CustomTextfeild(
              size: size,
              hintstr:
                  "${_globalcache.appstringrx[6].string[_globalcache.selectedlanguage.value]!}   ${_globalcache.selectedlanguage.value == englishlangstr ? "( optional )" : "( ?????????????? )"}   ",
              controller: _bloc.email,
              language: _globalcache.selectedlanguage.value,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                _globalcache.appstringrx[4]
                    .string[_globalcache.selectedlanguage.value]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.036,
                  color: grycol,
                ),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<bool>(
              stream: _bloc.loading.stream,
              initialData: false,
              builder: (context, loadingsnap) {
                if (loadingsnap.data!) {
                  return loadingwidget();
                } else {
                  return CustomButton(
                    size: size,
                    title: _globalcache.appstringrx[5]
                        .string[_globalcache.selectedlanguage.value]!,
                    func: () {
                      _bloc.signup(
                        () {
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  const BottomBar(),
                            ),
                            (route) => false,
                          );
                        },
                        (String id, String name, String email, String phone) {
                          _globalcache.changeuserdata(id, name, email, phone);
                          _globalcache.changegeust(false);
                        },
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _globalcache.appstringrx[7]
                      .string[_globalcache.selectedlanguage.value]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.036,
                    color: grycol,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    routepush(context, const LoginScreen(show: true));
                  },
                  child: Text(
                    _globalcache.appstringrx[1]
                        .string[_globalcache.selectedlanguage.value]!,
                    style: TextStyle(
                      fontSize: size.width * 0.038,
                      color: primarycol,
                      fontFamily: secondaryfontfamily,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: Container()),
                InkWell(
                  onTap: () async {
                    final SharedPreferences _pref =
                        await SharedPreferences.getInstance();
                    await _pref.setBool("Guest", true);
                    _globalcache.changegeust(true);
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const BottomBar(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    _globalcache.appstringrx[45]
                        .string[_globalcache.selectedlanguage.value]!,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: primarycol,
                      fontFamily: secondaryfontfamily,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
