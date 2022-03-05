import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import './../../../../domain/all.dart';

class DetailScreen extends StatefulWidget {
  final ResturantModel resto;
  const DetailScreen({Key? key, required this.resto}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _globalcache = Get.put(GlobalCache());
  final _listdish = ListDishStream();

  @override
  void initState() {
    List<DishModel> _list = [];
    for (int i = 0; i < _globalcache.dishlistrx.length; i++) {
      if (widget.resto.id == _globalcache.dishlistrx[i].restoid) {
        _list.add(_globalcache.dishlistrx[i]);
      }
    }
    _listdish.sink.add(_list);
    Future.delayed(const Duration(seconds: 0)).then((_) async {
      await FirebaseHelper.increaserestoviewfire(widget.resto.id);
      await FirebaseHelper.increaserestoviewuserfire(
        _globalcache.useridrx.value,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _listdish.dispose();
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
          widget.resto.name[_globalcache.selectedlanguage.value],
          style: const TextStyle(
            fontFamily: secondaryfontfamily,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () async {
                _globalcache.bookmarkiconpress(
                  widget.resto.id,
                  "true",
                  widget.resto.name[englishlangstr],
                );
                if (!_globalcache.favrestolistrx
                    .any((element) => element.id == widget.resto.id)) {
                  await FirebaseHelper.increaserestobookmarkfire(
                      widget.resto.id);
                  await FirebaseHelper.increaserestobookmarkuserfire(
                    _globalcache.useridrx.value,
                  );
                }
              },
              child: Icon(
                _globalcache.favrestolistrx
                        .any((element) => element.id == widget.resto.id)
                    ? Icons.bookmark_added_rounded
                    : Icons.bookmark_border_rounded,
                size: 25,
                color: whit,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              height: size.width * 0.3,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.resto.restopic.length,
                itemBuilder: (context, i) => Container(
                  margin: EdgeInsets.only(
                    left: i == 0 ? 10 : 5,
                    right: i == 4 ? 10 : 5,
                  ),
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomNetworkImage(image: widget.resto.restopic[i]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                children: [
                  CustomSmallTexticonbtn(
                    size: size,
                    title: mapstr[_globalcache.selectedlanguage.value]!,
                    icon: Icons.map_outlined,
                    onclick: () async {
                      await FirebaseHelper.increaserestomapfire(
                          widget.resto.id);
                      String _url =
                          "https://www.google.com/maps/search/?api=1&query=${widget.resto.latitude},${widget.resto.longitude}";
                      if (!await launch(_url)) throw 'Could not launch $_url';
                    },
                  ),
                  SizedBox(width: size.width * 0.04),
                  CustomSmallTexticonbtn(
                    size: size,
                    title: sharestr[_globalcache.selectedlanguage.value]!,
                    icon: Icons.share,
                    onclick: () async {
                      await FirebaseHelper.increaserestosharefire(
                          widget.resto.id);
                      Share.share(
                          "${widget.resto.name[_globalcache.selectedlanguage.value]}\n\n\n${widget.resto.description[_globalcache.selectedlanguage.value]}\n\n\n${timingstr[_globalcache.selectedlanguage.value]}:\n${widget.resto.timming[_globalcache.selectedlanguage.value]}\n\n\n${locationstr[_globalcache.selectedlanguage.value]}:\n${widget.resto.location[_globalcache.selectedlanguage.value]}\n\n\n${viewonmapstr[_globalcache.selectedlanguage.value]}:\nhttps://www.google.com/maps/search/?api=1&query=${widget.resto.latitude},${widget.resto.longitude}\n\n\nTo Download the App, Please click on the below link:\n\n${_globalcache.applinkrx.value}");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: containerdeco,
              child: ListView.builder(
                reverse: _globalcache.selectedlanguage.value == englishlangstr
                    ? false
                    : true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: widget.resto.tags.length,
                itemBuilder: (context, i) {
                  final _tagnamefetch =
                      _globalcache.fetchtagname(widget.resto.tags[i]);
                  if (_tagnamefetch != "null") {
                    return Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: _globalcache.selectedlanguage.value ==
                                  englishlangstr
                              ? BorderSide(
                                  width: i == (widget.resto.tags.length - 1)
                                      ? 0
                                      : 0.5,
                                  color: i == (widget.resto.tags.length - 1)
                                      ? whit
                                      : grycol,
                                )
                              : const BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                          left: _globalcache.selectedlanguage.value ==
                                  englishlangstr
                              ? const BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                )
                              : BorderSide(
                                  width: i == (widget.resto.tags.length - 1)
                                      ? 0
                                      : 0.5,
                                  color: i == (widget.resto.tags.length - 1)
                                      ? whit
                                      : grycol,
                                ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _tagnamefetch,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: txtcol,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.038,
                vertical: 15,
              ),
              decoration: containerdeco,
              child: Column(
                crossAxisAlignment:
                    _globalcache.selectedlanguage.value == englishlangstr
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                children: [
                  CustomLableUnderline(
                    size: size,
                    title: descriptionstr[_globalcache.selectedlanguage.value]!,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget
                        .resto.description[_globalcache.selectedlanguage.value],
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
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.038,
                        vertical: 15,
                      ),
                      decoration: containerdeco,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLableUnderline(
                            size: size,
                            title:
                                timingstr[_globalcache.selectedlanguage.value]!,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.resto
                                .timming[_globalcache.selectedlanguage.value],
                            style: timingstyle(size.width * 0.033),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Container(
                    width: size.width * 0.4,
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
                              locationstr[_globalcache.selectedlanguage.value]!,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.resto
                              .location[_globalcache.selectedlanguage.value],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            color: txtcol,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.038,
                vertical: 15,
              ),
              decoration: containerdeco,
              child: Column(
                children: [
                  CustomLableUnderline(
                    size: size,
                    title: menustr[_globalcache.selectedlanguage.value]!,
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<DishModel>>(
                    stream: _listdish.stream,
                    initialData: const [],
                    builder: (context, listsnap) {
                      if (listsnap.data!.isEmpty) {
                        return nodatafound("Dish List is Empty !", size);
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: size.width * 0.07,
                            mainAxisSpacing: 30,
                            childAspectRatio: 2 / 2.5,
                          ),
                          itemCount: listsnap.data!.length,
                          itemBuilder: (context, i) => MenuStemp(
                            size: size,
                            dish: listsnap.data![i],
                            onclick: () {
                              routepush(
                                context,
                                DishDetailScreen(
                                  dish: listsnap.data![i],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
