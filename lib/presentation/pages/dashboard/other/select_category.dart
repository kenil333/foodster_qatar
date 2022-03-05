// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import './../../../../domain/all.dart';

// class SelectCategoryScreen extends StatelessWidget {
//   const SelectCategoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _globalcache = Get.put(GlobalCache());
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: primarycol,
//       appBar: appbarpref(false, primarycol),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Align(
//               alignment: Alignment.center,
//               child: Image.asset(
//                 dashbordwhitimg,
//                 fit: BoxFit.contain,
//                 width: size.width * 0.7,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Stack(
//               children: [
//                 Container(
//                   width: size.width,
//                   padding: EdgeInsets.only(top: size.width * 1.18),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       HaxagonWidget(
//                         size: size,
//                         title: pizzastr[_globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: size.width,
//                   padding: EdgeInsets.only(top: size.width * 0.885),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       HaxagonWidget(
//                         size: size,
//                         title: dessertstr[_globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                       SizedBox(width: size.width * 0.03),
//                       HaxagonWidget(
//                         size: size,
//                         title: snackstr[_globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: size.width,
//                   padding: EdgeInsets.only(top: size.width * 0.59),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       HaxagonWidget(
//                         size: size,
//                         title: cafestr[_globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                       SizedBox(width: size.width * 0.03),
//                       HaxagonWidget(
//                         size: size,
//                         title: restaurantsstr[
//                             _globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                       SizedBox(width: size.width * 0.03),
//                       HaxagonWidget(
//                         size: size,
//                         title: dinnerstr[_globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: size.width,
//                   padding: EdgeInsets.only(top: size.width * 0.295),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       HaxagonWidget(
//                         size: size,
//                         title: lunchstr[_globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                       SizedBox(width: size.width * 0.03),
//                       HaxagonWidget(
//                         size: size,
//                         title:
//                             breakfaststr[_globalcache.selectedlanguage.value]!,
//                         onclick: () {
//                           routepush(context, const BottomBar());
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     HaxagonWidget(
//                       size: size,
//                       title: burgerstr[_globalcache.selectedlanguage.value]!,
//                       onclick: () {
//                         routepush(context, const BottomBar());
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
