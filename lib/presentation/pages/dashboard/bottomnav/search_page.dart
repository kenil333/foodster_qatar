import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import './../../../../domain/all.dart';

class SearchPage extends StatefulWidget {
  final Size size;
  const SearchPage({Key? key, required this.size}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _search = TextEditingController();
  final _globalcache = Get.put(GlobalCache());
  final _markers = MarkerStream();
  final _searchst = StringStream();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) async {
      BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(50, 50),
        ),
        Platform.isIOS ? mapmarkeriosimg : mapmarkerandroidimg,
      );
      _markers.sink.add(icon);
    });
    super.initState();
  }

  Future<void> _gotoresturant(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 15,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _markers.dispose();
    _searchst.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            width: widget.size.width,
            height: widget.size.height * 0.06,
            padding: const EdgeInsets.symmetric(vertical: 5),
            color: primarycol,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: whit,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.search,
                          size: 20,
                          color: txtcol,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _search,
                            style: const TextStyle(
                              color: txtcol,
                            ),
                            textAlign: _globalcache.selectedlanguage.value ==
                                    englishlangstr
                                ? TextAlign.left
                                : TextAlign.right,
                            onChanged: (String value) {
                              _searchst.sink.add(value);
                            },
                            decoration: InputDecoration(
                              hintText: searchstr[
                                  _globalcache.selectedlanguage.value],
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    String _getstr() {
                      String _str = "";
                      if (_globalcache.searchoprx.value ==
                          restaurantsstr[englishlangstr]) {
                        _str = restaurantsstr[englishlangstr]!;
                      }
                      if (_globalcache.searchoprx.value ==
                          restaurantsstr[arabiclangstr]) {
                        _str = restaurantsstr[arabiclangstr]!;
                      }
                      if (_globalcache.searchoprx.value ==
                          dishstr[englishlangstr]) {
                        _str = dishstr[englishlangstr]!;
                      }
                      if (_globalcache.searchoprx.value ==
                          dishstr[arabiclangstr]) {
                        _str = dishstr[arabiclangstr]!;
                      }
                      return _str;
                    }

                    showDialog(
                      context: context,
                      builder: (context) => Obx(
                        () => FilterDilog(
                          size: widget.size,
                          title:
                              "${selectsearchoptionstr[_globalcache.selectedlanguage.value]!} ${_getstr()}",
                          filterlits: [
                            restaurantsstr[
                                _globalcache.selectedlanguage.value]!,
                            dishstr[_globalcache.selectedlanguage.value]!,
                          ],
                          initialvalue: _globalcache.searchoprx.value,
                          onok: (String selected) {
                            _globalcache.changesearchoprx(selected);
                          },
                          btntxt: okstr[_globalcache.selectedlanguage.value]!,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.sort,
                    size: 25,
                    color: whit,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<BitmapDescriptor?>(
              stream: _markers.stream,
              builder: (context, markersnap) {
                if (markersnap.connectionState == ConnectionState.waiting) {
                  return loadingwidget();
                } else {
                  return StreamBuilder<String>(
                    stream: _searchst.stream,
                    initialData: null,
                    builder: (context, searchsnap) {
                      return Obx(
                        () {
                          Set<Marker> _markers = <Marker>{};
                          if (_globalcache.searchoprx.value ==
                                  restaurantsstr[englishlangstr] ||
                              _globalcache.searchoprx.value ==
                                  restaurantsstr[arabiclangstr]) {
                            for (int i = 0;
                                i < _globalcache.resturantlistrx.length;
                                i++) {
                              if (searchsnap.data == null) {
                                _markers.add(
                                  Marker(
                                    markerId: MarkerId(
                                      _globalcache.resturantlistrx[i].id,
                                    ),
                                    position: LatLng(
                                      _globalcache.resturantlistrx[i].latitude,
                                      _globalcache.resturantlistrx[i].longitude,
                                    ),
                                    infoWindow: InfoWindow(
                                      title: _globalcache
                                              .resturantlistrx[i].name[
                                          _globalcache.selectedlanguage.value],
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen: DetailScreen(
                                            resto:
                                                _globalcache.resturantlistrx[i],
                                          ),
                                          withNavBar: false,
                                        );
                                      },
                                    ),
                                    icon: markersnap.data!,
                                  ),
                                );
                              } else {
                                if (_globalcache.resturantlistrx[i]
                                    .name[_globalcache.selectedlanguage.value]
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchsnap.data!.toLowerCase())) {
                                  _markers.add(
                                    Marker(
                                      markerId: MarkerId(
                                          _globalcache.resturantlistrx[i].id),
                                      position: LatLng(
                                        _globalcache
                                            .resturantlistrx[i].latitude,
                                        _globalcache
                                            .resturantlistrx[i].longitude,
                                      ),
                                      infoWindow: InfoWindow(
                                        title: _globalcache
                                                .resturantlistrx[i].name[
                                            _globalcache
                                                .selectedlanguage.value],
                                        onTap: () {
                                          pushNewScreen(
                                            context,
                                            screen: DetailScreen(
                                              resto: _globalcache
                                                  .resturantlistrx[i],
                                            ),
                                            withNavBar: false,
                                          );
                                        },
                                      ),
                                      icon: markersnap.data!,
                                    ),
                                  );
                                  _gotoresturant(
                                    _globalcache.resturantlistrx[i].latitude,
                                    _globalcache.resturantlistrx[i].longitude,
                                  );
                                }
                              }
                            }
                          } else {
                            for (int i = 0;
                                i < _globalcache.dishlistrx.length;
                                i++) {
                              final _index =
                                  _globalcache.resturantlistrx.indexWhere(
                                (element) =>
                                    element.id ==
                                    _globalcache.dishlistrx[i].restoid,
                              );
                              if (searchsnap.data == null) {
                                _markers.add(
                                  Marker(
                                    markerId: MarkerId(_globalcache
                                        .resturantlistrx[_index].id),
                                    position: LatLng(
                                      _globalcache
                                          .resturantlistrx[_index].latitude,
                                      _globalcache
                                          .resturantlistrx[_index].longitude,
                                    ),
                                    infoWindow: InfoWindow(
                                      title: _globalcache
                                              .resturantlistrx[_index].name[
                                          _globalcache.selectedlanguage.value],
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen: DetailScreen(
                                            resto: _globalcache
                                                .resturantlistrx[_index],
                                          ),
                                          withNavBar: false,
                                        );
                                      },
                                    ),
                                    icon: markersnap.data!,
                                  ),
                                );
                              } else {
                                if (_globalcache.dishlistrx[i]
                                    .name[_globalcache.selectedlanguage.value]
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchsnap.data!.toLowerCase())) {
                                  _markers.add(
                                    Marker(
                                      markerId: MarkerId(_globalcache
                                          .resturantlistrx[_index].id),
                                      position: LatLng(
                                        _globalcache
                                            .resturantlistrx[_index].latitude,
                                        _globalcache
                                            .resturantlistrx[_index].longitude,
                                      ),
                                      infoWindow: InfoWindow(
                                        title: _globalcache
                                                .resturantlistrx[_index].name[
                                            _globalcache
                                                .selectedlanguage.value],
                                        onTap: () {
                                          pushNewScreen(
                                            context,
                                            screen: DetailScreen(
                                              resto: _globalcache
                                                  .resturantlistrx[_index],
                                            ),
                                            withNavBar: false,
                                          );
                                        },
                                      ),
                                      icon: markersnap.data!,
                                    ),
                                  );
                                  _gotoresturant(
                                    _globalcache
                                        .resturantlistrx[_index].latitude,
                                    _globalcache
                                        .resturantlistrx[_index].longitude,
                                  );
                                }
                              }
                            }
                          }

                          return GoogleMap(
                            mapType: MapType.terrain,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _globalcache.resturantlistrx.isNotEmpty
                                    ? _globalcache.resturantlistrx[0].latitude
                                    : 27.45678,
                                _globalcache.resturantlistrx.isNotEmpty
                                    ? _globalcache.resturantlistrx[0].longitude
                                    : 78.4587,
                              ),
                              zoom: 15,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            markers: _markers,
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
