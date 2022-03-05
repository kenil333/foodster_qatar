import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class PageDetailScreen extends StatelessWidget {
  final PageModel page;
  const PageDetailScreen({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _globalcache = Get.put(GlobalCache());
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: appbarpref(false, primarycol),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.06,
            padding: const EdgeInsets.only(bottom: 6),
            color: primarycol,
            alignment: Alignment.center,
            child: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  child: Image.asset(
                    dashbordwhitimg,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: size.width * 0.058,
                              color: whit,
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: 20,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.038,
                  vertical: 15,
                ),
                decoration: containerdeco,
                child: Column(
                  children: [
                    CustomLableUnderline(
                      size: size,
                      title:
                          "${page.title[_globalcache.selectedlanguage.value]}:",
                    ),
                    const SizedBox(height: 10),
                    Text(
                      page.content[_globalcache.selectedlanguage.value]!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: txtcol,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
