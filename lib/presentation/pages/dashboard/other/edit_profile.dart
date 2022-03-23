import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _bloc = EditProfileBloc();

  @override
  void dispose() {
    _bloc.namecont.dispose();
    _bloc.emailcont.dispose();
    _bloc.phonecont.dispose();
    _bloc.loading.dispose();
    super.dispose();
  }

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
              .appstringrx[21].string[_globalcache.selectedlanguage.value]!,
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
            CustomLable(
              size: size,
              title: _globalcache.usernamerx.value,
              language: _globalcache.selectedlanguage.value,
            ),
            CustomTextfeild(
              size: size,
              hintstr: _globalcache
                  .appstringrx[2].string[_globalcache.selectedlanguage.value]!,
              controller: _bloc.namecont,
              language: _globalcache.selectedlanguage.value,
            ),
            const SizedBox(height: 15),
            CustomLable(
              size: size,
              title: _globalcache.userphonerx.value,
              language: _globalcache.selectedlanguage.value,
            ),
            CustomTextfeild(
              size: size,
              hintstr: _globalcache
                  .appstringrx[3].string[_globalcache.selectedlanguage.value]!,
              controller: _bloc.phonecont,
              language: _globalcache.selectedlanguage.value,
              number: true,
              enable: false,
            ),
            const SizedBox(height: 15),
            CustomLable(
              size: size,
              title: _globalcache.useremailrx.value == "null"
                  ? "No Email"
                  : _globalcache.useremailrx.value,
              language: _globalcache.selectedlanguage.value,
            ),
            CustomTextfeild(
              size: size,
              hintstr: _globalcache
                  .appstringrx[6].string[_globalcache.selectedlanguage.value]!,
              controller: _bloc.emailcont,
              language: _globalcache.selectedlanguage.value,
            ),
            const SizedBox(height: 40),
            StreamBuilder<bool>(
              stream: _bloc.loading.stream,
              initialData: false,
              builder: (context, loadingsnap) {
                if (loadingsnap.data!) {
                  return loadingwidget();
                } else {
                  return CustomButton(
                    size: size,
                    title: _globalcache.appstringrx[22]
                        .string[_globalcache.selectedlanguage.value]!,
                    func: () {
                      _bloc.updateprofile(
                        _globalcache.useridrx.value,
                        _globalcache.usernamerx.value,
                        _globalcache.userphonerx.value,
                        _globalcache.useremailrx.value,
                        (String name, String phone, String email) {
                          _globalcache.changeuserdata(
                            _globalcache.useridrx.value,
                            name,
                            email,
                            phone,
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
