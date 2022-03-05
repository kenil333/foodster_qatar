import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class DishDetailScreen extends StatefulWidget {
  final DishModel dish;
  const DishDetailScreen({Key? key, required this.dish}) : super(key: key);

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  final _globalcache = Get.put(GlobalCache());

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) async {
      await FirebaseHelper.increasedishviewfire(widget.dish.restoid);
      await FirebaseHelper.increasedishviewuserfire(
        _globalcache.useridrx.value,
      );
    });
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
          widget.dish.name[_globalcache.selectedlanguage.value],
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
                  widget.dish.id,
                  "false",
                  widget.dish.name[englishlangstr],
                );
                if (!_globalcache.favdishlistrx
                    .any((element) => element.id == widget.dish.id)) {
                  await FirebaseHelper.increasedishebookmarkfire(
                      widget.dish.restoid);
                  await FirebaseHelper.increasedishbookmarkuserfire(
                    _globalcache.useridrx.value,
                  );
                }
              },
              child: Icon(
                _globalcache.favdishlistrx
                        .any((element) => element.id == widget.dish.id)
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
            Container(
              width: double.infinity,
              height: size.height * 0.36,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.36,
                      child: InkWell(
                        onTap: () {
                          routepush(
                            context,
                            ZoomScreen(image: widget.dish.images[0]),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              CustomNetworkImage(image: widget.dish.images[0]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.025),
                  SizedBox(
                    width: size.height * 0.09,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.dish.images.length - 1,
                      itemBuilder: (context, i) => Container(
                        width: double.infinity,
                        height: size.height * 0.09,
                        padding: EdgeInsets.only(bottom: size.height * 0.005),
                        child: InkWell(
                          onTap: () {
                            routepush(
                              context,
                              ZoomScreen(image: widget.dish.images[i + 1]),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomNetworkImage(
                                image: widget.dish.images[i + 1]),
                          ),
                        ),
                      ),
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
                        vertical: 12,
                      ),
                      decoration: containerdeco,
                      child: Text(
                        _globalcache.fetchrestoname(widget.dish.restoid),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: txtcol,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Container(
                    width: size.width * 0.36,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.038,
                      vertical: 12,
                    ),
                    decoration: containerdeco,
                    child: Text(
                      "QAR ${widget.dish.price.toStringAsFixed(0)}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: txtcol,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: widget.dish.tags.length,
                reverse: _globalcache.selectedlanguage.value == englishlangstr
                    ? false
                    : true,
                itemBuilder: (context, i) {
                  final _tagnamefetch =
                      _globalcache.fetchtagname(widget.dish.tags[i]);

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
                                  width: i == (widget.dish.tags.length - 1)
                                      ? 0
                                      : 0.5,
                                  color: i == (widget.dish.tags.length - 1)
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
                                  width: i == (widget.dish.tags.length - 1)
                                      ? 0
                                      : 0.5,
                                  color: i == (widget.dish.tags.length - 1)
                                      ? whit
                                      : grycol,
                                ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _globalcache.fetchtagname(widget.dish.tags[i]),
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
                        .dish.description[_globalcache.selectedlanguage.value],
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
            CustomButton(
              size: size,
              title: gotorestostr[_globalcache.selectedlanguage.value]!,
              func: () {
                final int _index = _globalcache.resturantlistrx
                    .indexWhere((e) => e.id == widget.dish.restoid);
                routepush(
                  context,
                  DetailScreen(resto: _globalcache.resturantlistrx[_index]),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
