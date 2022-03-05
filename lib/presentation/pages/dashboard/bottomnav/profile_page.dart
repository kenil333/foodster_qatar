import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../../domain/all.dart';

class ProfilePage extends StatelessWidget {
  final Size size;
  const ProfilePage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.06,
          padding: const EdgeInsets.only(bottom: 6),
          color: primarycol,
          alignment: Alignment.center,
          child: Image.asset(
            dashbordwhitimg,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: size.width * 0.07,
                            color: txtcol,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: const EditProfileScreen(),
                              withNavBar: false,
                            );
                          },
                          child: Container(
                            width: size.width * 0.09,
                            height: size.width * 0.09,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primarycol,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: size.width * 0.05,
                              color: whit,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomLable(
                    size: size,
                    title: namestr[_globalcache.selectedlanguage.value]!,
                    language: _globalcache.selectedlanguage.value,
                  ),
                  CustomContainer(
                    size: size,
                    containervalue: _globalcache.usernamerx.value,
                    language: _globalcache.selectedlanguage.value,
                  ),
                  const SizedBox(height: 20),
                  CustomLable(
                    size: size,
                    title: phonenumberstr[_globalcache.selectedlanguage.value]!,
                    language: _globalcache.selectedlanguage.value,
                  ),
                  CustomContainer(
                    size: size,
                    containervalue: _globalcache.userphonerx.value,
                    language: _globalcache.selectedlanguage.value,
                  ),
                  const SizedBox(height: 20),
                  CustomLable(
                    size: size,
                    title: emailstr[_globalcache.selectedlanguage.value]!,
                    language: _globalcache.selectedlanguage.value,
                  ),
                  CustomContainer(
                    size: size,
                    containervalue: _globalcache.useremailrx.value,
                    language: _globalcache.selectedlanguage.value,
                  ),
                  const SizedBox(height: 30),
                  CustomLable(
                    size: size,
                    title:
                        selectlanguagestr[_globalcache.selectedlanguage.value]!,
                    language: _globalcache.selectedlanguage.value,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomHalfButon(
                          size: size,
                          title: englishlangstr,
                          onclick: () async {
                            final SharedPreferences _pref =
                                await SharedPreferences.getInstance();
                            await _pref.setString("Language", englishlangstr);
                            _globalcache.changeselectedlanguage(englishlangstr);
                          },
                        ),
                        CustomHalfButon(
                          size: size,
                          title: arabiclangstr,
                          onclick: () async {
                            final SharedPreferences _pref =
                                await SharedPreferences.getInstance();
                            await _pref.setString("Language", arabiclangstr);
                            _globalcache.changeselectedlanguage(arabiclangstr);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: 5,
                    ),
                    decoration: containerdeco,
                    child: StreamBuilder(
                      stream: FirebaseHelper.pagestream(),
                      builder: (context, pagesnap) {
                        if (pagesnap.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else if ((pagesnap.data as DatabaseEvent)
                                    .snapshot
                                    .value !=
                                null &&
                            pagesnap.hasData &&
                            !pagesnap.hasError) {
                          List<PageModel> _list = [];
                          final Map _data = ((pagesnap.data as DatabaseEvent)
                              .snapshot
                              .value as Map);
                          _data.forEach(
                            (key, value) {
                              _list.add(PageModel.fromfire(key, value));
                            },
                          );
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _list.length,
                            itemBuilder: (context, i) => CustomTextsendBtn(
                              size: size,
                              title: _list[i]
                                  .title[_globalcache.selectedlanguage.value]!,
                              border: (_list.length - 1) == i ? false : true,
                              onclick: () {
                                pushNewScreen(
                                  context,
                                  screen: PageDetailScreen(
                                    page: _list[i],
                                  ),
                                  withNavBar: false,
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () async {
                          final SharedPreferences _pref =
                              await SharedPreferences.getInstance();
                          await _pref.setString("Email", "logout");
                          await _pref.setString("Phone", "logout");
                          pushNewScreen(
                            context,
                            screen: const LoginScreen(show: false),
                            withNavBar: false,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.08,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: primarycol.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                logoutstr[_globalcache.selectedlanguage.value]!,
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  color: primarycol,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.logout_outlined,
                                color: primarycol,
                                size: size.width * 0.07,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
