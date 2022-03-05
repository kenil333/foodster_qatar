import 'package:foodster/data/datamodel/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class SplashBloc {
  autologin(
    Function forward,
    Function notlogin,
    Function setfav,
    Function setcache,
    Function setlangugae,
  ) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    final String _lang = _pref.getString("Language") ?? englishlangstr;
    setlangugae(_lang);
    final List<NotificationModel> _notification =
        await FirebaseHelper.getnotifications();
    await NotificationService().cancleall();
    for (int i = 0; i < _notification.length; i++) {
      NotificationService().schedulenotification(
        _notification[i].notiid,
        _notification[i].name[_lang],
        _notification[i].message[_lang],
        _notification[i].hour,
        _notification[i].minute,
        _notification[i].date,
      );
    }
    final String _name = _pref.getString("Name") ?? "null";
    final String _phone = _pref.getString("Phone") ?? "null";
    if (_name == "null" || _phone == "null") {
      notlogin();
    } else {
      setfav();
      if (_name == "logout" || _phone == "logout") {
        notlogin();
      } else {
        await FirebaseHelper.loginfire(_name, _phone, setcache).then(
          (String result) {
            if (result == "Go") {
              forward();
            } else {
              notlogin();
            }
          },
        );
      }
    }
  }
}
