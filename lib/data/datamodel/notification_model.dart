import 'package:intl/intl.dart';

import './../../domain/all.dart';

class NotificationModel {
  final String id;
  final int notiid;
  final Map name;
  final Map message;
  final DateTime date;
  final String hour;
  final String minute;

  NotificationModel({
    required this.id,
    required this.notiid,
    required this.name,
    required this.message,
    required this.date,
    required this.hour,
    required this.minute,
  });

  factory NotificationModel.fromfire(String key, Map data) {
    int _hour = int.parse("${data["Time"][0]}${data["Time"][1]}");
    // if (int.parse("${data["Time"][0]}${data["Time"][1]}") > 12) {
    //   _hour = _hour - 12;
    // }
    final int _notiid = int.parse(
        "${DateFormat("dd").format(DateTime.parse(data["Date"]))}$_hour${data["Time"][3]}${data["Time"][4]}");
    return NotificationModel(
      id: key,
      notiid: _notiid,
      name: {
        englishlangstr: data["NameEnglish"],
        arabiclangstr: data["NameArabic"],
      },
      message: {
        englishlangstr: data["MessageEnglish"],
        arabiclangstr: data["MessageArabic"],
      },
      date: DateTime.parse(data["Date"]),
      hour: _hour.toString().length == 1 ? "0$_hour" : _hour.toString(),
      minute: ("${data["Time"][3]}${data["Time"][4]}").length == 1
          ? "0${data["Time"][3]}${data["Time"][4]}"
          : "${data["Time"][3]}${data["Time"][4]}",
    );
  }
}
