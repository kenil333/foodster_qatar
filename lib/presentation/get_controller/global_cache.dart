import 'package:get/get.dart';
import 'package:intl/intl.dart';

import './../../domain/all.dart';

class GlobalCache extends GetxController {
  RxString selectedlanguage = englishlangstr.obs;
  RxString useridrx = "".obs;
  RxString usernamerx = "".obs;
  RxString useremailrx = "".obs;
  RxString userphonerx = "".obs;
  RxBool geustrx = false.obs;
  // RxDouble latituderx = 0.0.obs;
  // RxDouble longituderx = 0.0.obs;
  RxString selbookmark = "A to Z".obs;
  RxString searchoprx = "".obs;
  RxList<ResturantModel> resturantlistrx = <ResturantModel>[].obs;
  RxList<DishModel> dishlistrx = <DishModel>[].obs;
  RxList<CategoryModel> categorylistrx = <CategoryModel>[].obs;
  RxList<CategoryModel> caterestolistrx = <CategoryModel>[].obs;
  RxList<CategoryModel> catedishlistrx = <CategoryModel>[].obs;
  RxList<TagModel> taglistrx = <TagModel>[].obs;
  RxList<BookmarkModel> favrestolistrx = <BookmarkModel>[].obs;
  RxList<BookmarkModel> favdishlistrx = <BookmarkModel>[].obs;
  RxString applinkrx = "".obs;
  RxList<AppString> appstringrx = <AppString>[].obs;

  changegeust(bool value) => geustrx.value = value;

  changeappstring(List<AppString> list) => appstringrx.value = list;

  changeuserdata(String idi, String namei, String emaili, String phonei) {
    useridrx.value = idi;
    usernamerx.value = namei;
    useremailrx.value = emaili;
    userphonerx.value = phonei;
  }

  changeselectedlanguage(String langugae) => selectedlanguage.value = langugae;

  // changelatlong(double lati, double longi) {
  //   latituderx.value = lati;
  //   longituderx.value = longi;
  // }

  changeselbookmark(String value) => selbookmark.value = value;

  changesearchoprx(String value) => searchoprx.value = value;

  changerestolist(List<ResturantModel> fromlist) =>
      resturantlistrx.value = fromlist;

  changedishlist(List<DishModel> fromlist) => dishlistrx.value = fromlist;

  changecategorylist(List<CategoryModel> fromlist) {
    categorylistrx.value = fromlist;
    List<CategoryModel> cateresto = [];
    List<CategoryModel> catedish = [];
    for (int i = 0; i < fromlist.length; i++) {
      if (fromlist[i].displaytype == "Restaurants") {
        cateresto.add(fromlist[i]);
      } else {
        catedish.add(fromlist[i]);
      }
    }
    caterestolistrx.value = cateresto;
    catedishlistrx.value = catedish;
  }

  changetaglist(List<TagModel> fromlist) => taglistrx.value = fromlist;

  changefavrestolist(List<BookmarkModel> fromlist) =>
      favrestolistrx.value = fromlist;

  changefavdishlist(List<BookmarkModel> fromlist) =>
      favdishlistrx.value = fromlist;

  changeapplink(String link) => applinkrx.value = link;

  String fetchtagname(String id) {
    final _index = taglistrx.indexWhere((element) => element.id == id);
    if (_index == -1) {
      return "null";
    } else {
      return taglistrx[_index].name[selectedlanguage.value]!;
    }
  }

  String fetchrestoname(String id) {
    final _index = resturantlistrx.indexWhere((element) => element.id == id);
    return resturantlistrx[_index].name[selectedlanguage.value];
  }

  ResturantModel fetchrestomodel(String id) {
    final _index = resturantlistrx.indexWhere((element) => element.id == id);
    return resturantlistrx[_index];
  }

  DishModel fetchdishmodel(String id) {
    final _index = dishlistrx.indexWhere((element) => element.id == id);
    return dishlistrx[_index];
  }

  Future<void> fetchbookmarks() async {
    List<BookmarkModel> _restolist = [];
    List<BookmarkModel> _dishlist = [];
    final _bookmarks = await BookmarkDbHelper.getData();
    for (int i = 0; i < _bookmarks.length; i++) {
      if (_bookmarks[i]["resto"] == "true") {
        _restolist.add(
          BookmarkModel(
            id: _bookmarks[i]["id"],
            name: _bookmarks[i]["name"],
            date: DateTime.parse(_bookmarks[i]["date"]),
          ),
        );
      } else {
        _dishlist.add(
          BookmarkModel(
            id: _bookmarks[i]["id"],
            name: _bookmarks[i]["name"],
            date: DateTime.parse(_bookmarks[i]["date"]),
          ),
        );
      }
    }
    if (_restolist.length > 1) {
      _restolist.sort((a, b) => a.name.compareTo(b.name));
    }
    if (_dishlist.length > 1) {
      _dishlist.sort((a, b) => a.name.compareTo(b.name));
    }
    changefavrestolist(_restolist);
    changefavdishlist(_dishlist);
  }

  bookmarkiconpress(String id, String resto, String name) {
    final _found = foundbookmarks(id, resto);
    if (_found) {
      removefromfavbookmarks(id, resto);
    } else {
      addintofavbookmarks(id, resto, name);
    }
  }

  foundbookmarks(String id, String resto) {
    if (resto == "true") {
      return favrestolistrx.any((element) => element.id == id);
    } else {
      return favdishlistrx.any((element) => element.id == id);
    }
  }

  addintofavbookmarks(String id, String resto, String name) async {
    await BookmarkDbHelper.insert({
      "id": id,
      "name": name,
      "resto": resto,
      "date": DateFormat("yyyyMMdd").format(DateTime.now()),
    });
    if (resto == "true") {
      favrestolistrx.add(
        BookmarkModel(
          id: id,
          name: name,
          date: DateTime.parse(
            DateFormat("yyyyMMdd").format(DateTime.now()),
          ),
        ),
      );
    } else {
      favdishlistrx.add(
        BookmarkModel(
          id: id,
          name: name,
          date: DateTime.parse(
            DateFormat("yyyyMMdd").format(DateTime.now()),
          ),
        ),
      );
    }
  }

  removefromfavbookmarks(String id, String resto) async {
    await BookmarkDbHelper.delete(id);
    if (resto == "true") {
      final int _index =
          favrestolistrx.indexWhere((element) => element.id == id);
      favrestolistrx.removeAt(_index);
    } else {
      final int _index =
          favdishlistrx.indexWhere((element) => element.id == id);
      favdishlistrx.removeAt(_index);
    }
  }
}
