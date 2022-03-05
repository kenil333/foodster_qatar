import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class CateRestolistScreen extends StatefulWidget {
  final CategoryModel category;
  const CateRestolistScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CateRestolistScreen> createState() => _CateRestolistScreenState();
}

class _CateRestolistScreenState extends State<CateRestolistScreen> {
  final _globalcache = Get.put(GlobalCache());
  final _listresto = ListRestoStream();

  @override
  void initState() {
    List<ResturantModel> _list = [];
    for (int i = 0; i < _globalcache.resturantlistrx.length; i++) {
      for (int j = 0; j < _globalcache.resturantlistrx[i].tags.length; j++) {
        if (widget.category.tags
            .contains(_globalcache.resturantlistrx[i].tags[j])) {
          if (!_list.any((e) => e.id == _globalcache.resturantlistrx[i].id)) {
            _list.add(_globalcache.resturantlistrx[i]);
          }
        }
      }
    }
    _listresto.sink.add(_list);
    super.initState();
  }

  @override
  void dispose() {
    _listresto.dispose();
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
          widget.category.name[_globalcache.selectedlanguage.value]!,
          style: const TextStyle(
            fontFamily: secondaryfontfamily,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   GestureDetector(
        //     onTap: () {},
        //     child: const Icon(
        //       Icons.sort,
        //       size: 25,
        //       color: whit,
        //     ),
        //   ),
        //   const SizedBox(width: 10),
        // ],
      ),
      body: StreamBuilder<List<ResturantModel>>(
        stream: _listresto.stream,
        builder: (context, listsnap) {
          if (listsnap.connectionState == ConnectionState.waiting) {
            return loadingwidget();
          } else if (listsnap.data!.isEmpty) {
            return nodatafound(
              restolistemptystr[_globalcache.selectedlanguage.value]!,
              size,
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: listsnap.data!.length,
              itemBuilder: (context, i) => ResturentStemp(
                size: size,
                resto: listsnap.data![i],
                onclick: () {
                  routepush(
                    context,
                    DetailScreen(
                      resto: listsnap.data![i],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
