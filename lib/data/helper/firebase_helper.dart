import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
// import 'package:foodster/data/constant/dummy_const.dart';
import 'package:foodster/data/datamodel/notification_model.dart';
import 'package:intl/intl.dart';

import './../../domain/all.dart';

class FirebaseHelper {
  static final _fire = FirebaseDatabase.instance;

  static Stream resturantstream() {
    return _fire.ref("Resturants").onValue;
  }

  static Stream dishstream() {
    return _fire.ref("Dishes").onValue;
  }

  static Stream categorytagstream() {
    return _fire.ref("CategoryTags").onValue;
  }

  static Stream bannerstream() {
    return _fire.ref("Banners").onValue;
  }

  static Stream pagestream() {
    return _fire.ref("Pages").onValue;
  }

  static Future<bool> signupfire(
    String name,
    String phone,
    String email,
    String date,
    Function setcache,
  ) async {
    final DatabaseEvent _find =
        await _fire.ref("Users").orderByChild("Phone").equalTo(phone).once();
    if (_find.snapshot.value == null) {
      await _fire.ref("Users").push().set({
        "Email": email,
        "Phone": phone,
        "Name": name,
        "Date": date,
        "UserSection": "Customer",
      });
      await _fire.ref("Users").orderByChild("Phone").equalTo(phone).once().then(
        (DatabaseEvent event) {
          (event.snapshot.value as Map).forEach((key, value) {
            setcache(key, value["Name"], value["Email"], value["Phone"]);
          });
        },
      );
      return true;
    } else {
      return false;
    }
  }

  static Future<String> loginfire(
    String name,
    String phone,
    Function setcache,
  ) async {
    String rtnstr = "Go";
    String _id = "";
    String _name = "";
    String _email = "";
    String _phone = "";
    await _fire.ref("Users").orderByChild("Phone").equalTo(phone).once().then(
      (DatabaseEvent event) {
        if (event.snapshot.value == null) {
          rtnstr = "Phone number is not Found !";
        } else {
          (event.snapshot.value as Map).forEach((key, value) {
            if (value["UserSection"] != "Customer") {
              rtnstr = "Name and Phone number is not found !";
            } else {
              if (name != value["Name"]) {
                rtnstr = "Name is Wrong!";
              } else {
                _id = key;
                _name = value["Name"];
                _email = value["Email"];
                _phone = value["Phone"];
              }
            }
          });
        }
      },
    );
    if (rtnstr == "Go") {
      setcache(_id, _name, _email, _phone);
    }
    return rtnstr;
  }

  static Future<void> setalldata(
    Function setresto,
    Function setdishe,
    Function setcatetags,
  ) async {
    List<ResturantModel> _restolist = [];
    await _fire
        .ref("Resturants")
        .orderByChild("Display")
        .equalTo("Yes")
        .once()
        .then(
      (DatabaseEvent event) {
        if (event.snapshot.value != null) {
          (event.snapshot.value as Map).forEach(
            (key, value) {
              _restolist.add(ResturantModel.formfire(key, value));
            },
          );
        }
        if (_restolist.length > 1) {
          _restolist.sort((a, b) => a.number.compareTo(b.number));
        }
        setresto(_restolist);
      },
    );
    await _fire.ref("Dishes").once().then(
      (DatabaseEvent event) {
        List<DishModel> _dishlist = [];
        if (event.snapshot.value != null) {
          (event.snapshot.value as Map).forEach(
            (key, value) {
              if (_restolist.any((element) => element.id == value["RestoId"])) {
                _dishlist.add(DishModel.fromfire(key, value));
              }
            },
          );
        }
        setdishe(_dishlist);
      },
    );
    await _fire.ref("CategoryTags").once().then(
      (DatabaseEvent event) {
        List<CategoryModel> _category = [];
        List<TagModel> _tags = [];
        if (event.snapshot.value != null) {
          if ((event.snapshot.value as Map)["Category"] != null) {
            (event.snapshot.value as Map)["Category"].forEach(
              (key, value) {
                _category.add(CategoryModel.fromfire(key, value));
              },
            );
          }
          if ((event.snapshot.value as Map)["Tags"] != null) {
            (event.snapshot.value as Map)["Tags"].forEach(
              (key, value) {
                _tags.add(TagModel.fromfire(key, value));
              },
            );
          }
        }
        if (_category.length > 1) {
          _category.sort((a, b) => a.number.compareTo(b.number));
        }
        setcatetags(_category, _tags);
      },
    );
  }

  static Future<List<NotificationModel>> getnotifications() async {
    List<NotificationModel> _notifications = [];
    await _fire.ref("Notifications").once().then(
      (DatabaseEvent event) {
        if (event.snapshot.value != null) {
          (event.snapshot.value as Map).forEach(
            (key, value) {
              if (value["Date"] ==
                  DateFormat("yyyyMMdd").format(DateTime.now())) {
                if (int.parse("${value["Time"][0]}${value["Time"][1]}") >=
                    int.parse(DateFormat("H").format(DateTime.now()))) {
                  _notifications.add(
                    NotificationModel.fromfire(key, value),
                  );
                }
              } else {
                if (DateTime.parse(value["Date"]).isAfter(DateTime.now())) {
                  _notifications.add(
                    NotificationModel.fromfire(key, value),
                  );
                }
              }
            },
          );
        }
      },
    );
    return _notifications;
  }

  static Future<void> updateprofilefire(
    String id,
    String name,
    String phone,
    String email,
  ) async {
    await _fire.ref("Users/$id").update({
      "Name": name,
      "Phone": phone,
      "Email": email,
    });
  }

  static Future<String> getandroidioslink() async {
    String _link = "null";
    if (Platform.isAndroid) {
      _fire.ref("Android").once().then(
        (DatabaseEvent event) {
          _link = event.snapshot.value as String;
        },
      );
    } else {
      _fire.ref("iOS").once().then(
        (DatabaseEvent event) {
          _link = event.snapshot.value as String;
        },
      );
    }
    return _link;
  }

  static Future<void> increaserestoviewfire(String id) async {
    await _fire
        .ref("Resturants/$id/Analytics/View/RestoView")
        .push()
        .set(DateFormat("yyyyMMdd").format(DateTime.now()));
  }

  static Future<void> increasedishviewfire(String id) async {
    await _fire
        .ref("Resturants/$id/Analytics/View/DishView")
        .push()
        .set(DateFormat("yyyyMMdd").format(DateTime.now()));
  }

  static Future<void> increaserestobookmarkfire(String id) async {
    await _fire
        .ref("Resturants/$id/Analytics/Bookmarks/RestoBookmark")
        .push()
        .set(DateFormat("yyyyMMdd").format(DateTime.now()));
  }

  static Future<void> increasedishebookmarkfire(String id) async {
    await _fire
        .ref("Resturants/$id/Analytics/Bookmarks/DishBookmark")
        .push()
        .set(DateFormat("yyyyMMdd").format(DateTime.now()));
  }

  static Future<void> increaserestosharefire(String id) async {
    await _fire
        .ref("Resturants/$id/Analytics/Share")
        .push()
        .set(DateFormat("yyyyMMdd").format(DateTime.now()));
  }

  static Future<void> increaserestomapfire(String id) async {
    await _fire
        .ref("Resturants/$id/Analytics/Map")
        .push()
        .set(DateFormat("yyyyMMdd").format(DateTime.now()));
  }

  ///User data Changes

  static Future<void> increaserestoviewuserfire(String id) async {
    if (id.isNotEmpty) {
      await _fire
          .ref("Users/$id/Analytics/RestoView")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    } else {
      await _fire
          .ref("Users/-Mcbcthusgj3234guest/Analytics/RestoView")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    }
  }

  static Future<void> increasedishviewuserfire(String id) async {
    if (id.isNotEmpty) {
      await _fire
          .ref("Users/$id/Analytics/DishView")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    } else {
      await _fire
          .ref("Users/-Mcbcthusgj3234guest/Analytics/DishView")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    }
  }

  static Future<void> increaserestobookmarkuserfire(String id) async {
    if (id.isNotEmpty) {
      await _fire
          .ref("Users/$id/Analytics/RestoBookmark")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    } else {
      await _fire
          .ref("Users/-Mcbcthusgj3234guest/Analytics/RestoBookmark")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    }
  }

  static Future<void> increasedishbookmarkuserfire(String id) async {
    if (id.isNotEmpty) {
      await _fire
          .ref("Users/$id/Analytics/DishBookmark")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    } else {
      await _fire
          .ref("Users/-Mcbcthusgj3234guest/Analytics/DishBookmark")
          .push()
          .set(DateFormat("yyyyMMdd").format(DateTime.now()));
    }
  }

  // static Future<void> addintofirebasestr() async {
  //   for (int i = 0; i < doremon.length; i++) {
  //     await _fire.ref("AppString/$i").set(
  //           doremon[i],
  //         );
  //   }
  // }

  static Future<List<AppString>> getappstrings() async {
    List<AppString> _list = [];
    final DatabaseEvent _event = await _fire.ref("AppString").once();
    _list = (_event.snapshot.value as List)
        .map((e) => AppString.fromfire(e))
        .toList();
    return _list;
  }

  // static Future<void> increaserestoviewfire(String id) async {
  //   int _count = 1;
  //   await _fire
  //       .ref("Resturants/$id/View")
  //       .once()
  //       .then((DatabaseEvent event) async {
  //     if (event.snapshot.value != null) {
  //       _count += (event.snapshot.value as int);
  //     }
  //     await _fire.ref("Resturants/$id/View").set(_count);
  //   });
  // }

  // static Future<void> increasedishviewfire(String id) async {
  //   int _count = 1;
  //   await _fire.ref("Dishes/$id/View").once().then((DatabaseEvent event) async {
  //     if (event.snapshot.value != null) {
  //       _count += (event.snapshot.value as int);
  //     }
  //     await _fire.ref("Dishes/$id/View").set(_count);
  //   });
  // }

  // static Future<void> increaserestobookmarkfire(String id) async {
  //   int _count = 1;
  //   await _fire
  //       .ref("Resturants/$id/Bookmarks")
  //       .once()
  //       .then((DatabaseEvent event) async {
  //     if (event.snapshot.value != null) {
  //       _count += (event.snapshot.value as int);
  //     }
  //     await _fire.ref("Resturants/$id/Bookmarks").set(_count);
  //   });
  // }

  // static Future<void> increasedishebookmarkfire(String id) async {
  //   int _count = 1;
  //   await _fire
  //       .ref("Dishes/$id/Bookmarks")
  //       .once()
  //       .then((DatabaseEvent event) async {
  //     if (event.snapshot.value != null) {
  //       _count += (event.snapshot.value as int);
  //     }
  //     await _fire.ref("Dishes/$id/Bookmarks").set(_count);
  //   });
  // }
}
