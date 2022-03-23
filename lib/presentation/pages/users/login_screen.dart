import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class LoginScreen extends StatefulWidget {
  final bool show;
  const LoginScreen({Key? key, required this.show}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (widget.show) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SignupScreen(),
            ),
            (route) => false,
          );
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: screenback,
        appBar: AppBar(
          backgroundColor: primarycol,
          title: Text(
            _globalcache
                .appstringrx[1].string[_globalcache.selectedlanguage.value]!,
            style: const TextStyle(
              fontFamily: secondaryfontfamily,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SigninImgWid(size: size),
              const SizedBox(height: 20),
              CustomTextfeild(
                size: size,
                hintstr: _globalcache.appstringrx[2]
                    .string[_globalcache.selectedlanguage.value]!,
                controller: _bloc.name,
                language: _globalcache.selectedlanguage.value,
              ),
              const SizedBox(height: 10),
              CustomTextfeild(
                size: size,
                hintstr: _globalcache.appstringrx[3]
                    .string[_globalcache.selectedlanguage.value]!,
                controller: _bloc.phone,
                language: _globalcache.selectedlanguage.value,
                number: true,
              ),
              const SizedBox(height: 40),
              StreamBuilder<bool>(
                stream: _bloc.loading.stream,
                initialData: false,
                builder: (context, loadinsnap) {
                  if (loadinsnap.data!) {
                    return loadingwidget();
                  } else {
                    return CustomButton(
                      size: size,
                      title: _globalcache.appstringrx[1]
                          .string[_globalcache.selectedlanguage.value]!,
                      func: () {
                        _bloc.login(
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
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
