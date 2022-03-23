import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class CateDishListScren extends StatefulWidget {
  final CategoryModel category;
  const CateDishListScren({Key? key, required this.category}) : super(key: key);

  @override
  State<CateDishListScren> createState() => _CateDishListScrenState();
}

class _CateDishListScrenState extends State<CateDishListScren> {
  final _globalcache = Get.put(GlobalCache());
  final _listdish = ListDishStream();

  @override
  void initState() {
    List<DishModel> _dishes = [];
    for (int i = 0; i < _globalcache.dishlistrx.length; i++) {
      for (int j = 0; j < _globalcache.dishlistrx[i].tags.length; j++) {
        if (widget.category.tags.contains(_globalcache.dishlistrx[i].tags[j])) {
          if ((_dishes.any(
                  (element) => element.id == _globalcache.dishlistrx[i].id)) ==
              false) {
            _dishes.add(_globalcache.dishlistrx[i]);
          }
        }
      }
    }
    _listdish.sink.add(_dishes);
    super.initState();
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
      body: StreamBuilder<List<DishModel>>(
          stream: _listdish.stream,
          builder: (context, listsnap) {
            if (listsnap.connectionState == ConnectionState.waiting) {
              return loadingwidget();
            } else if (listsnap.data!.isEmpty) {
              return Center(
                child: nodatafound(
                    _globalcache.appstringrx[47]
                        .string[_globalcache.selectedlanguage.value]!,
                    size),
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                  vertical: 15,
                ),
                itemCount: listsnap.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: size.width * 0.02,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2 / 2,
                ),
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () {
                      routepush(
                        context,
                        DishDetailScreen(dish: listsnap.data![i]),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomNetworkImage(
                          image: listsnap.data![i].images[0]),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
