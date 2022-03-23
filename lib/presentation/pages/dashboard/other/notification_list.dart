// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import './../../../../domain/all.dart';

// class MotificationListScreen extends StatelessWidget {
//   const MotificationListScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _globalcache = Get.put(GlobalCache());
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: screenback,
//       appBar: appbarpref(false, primarycol),
//       body: Column(
//         children: [
//           Container(
//             width: size.width,
//             height: size.height * 0.06,
//             padding: const EdgeInsets.only(bottom: 6),
//             color: primarycol,
//             alignment: Alignment.center,
//             child: Stack(
//               children: [
//                 SizedBox(
//                   width: size.width,
//                   child: Image.asset(
//                     dashbordwhitimg,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 SizedBox(
//                   width: size.width,
//                   child: Column(
//                     children: [
//                       Expanded(child: Container()),
//                       Row(
//                         children: [
//                           const SizedBox(width: 10),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Icon(
//                               Icons.arrow_back_ios_rounded,
//                               size: size.width * 0.058,
//                               color: whit,
//                             ),
//                           ),
//                           Expanded(child: Container()),
//                         ],
//                       ),
//                       Expanded(child: Container()),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 15),
//                   Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: size.width * 0.05),
//                     child: CustomLableUnderline(
//                       size: size,
//                       title:
//                           "${notificationstr[_globalcache.selectedlanguage.value]!}:",
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   ListView.builder(
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: 2,
//                     itemBuilder: (context, i) => ReminderWidget(
//                       size: size,
//                       title: "08:00",
//                       initialbool: true,
//                       onclick: (bool value) {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
