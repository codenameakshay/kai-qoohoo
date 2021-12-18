import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  late SharedPreferences prefs;

  Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool("realisticData") ?? false;
  }

  bool getRealisticData() {
    return prefs.getBool("realisticData") ?? false;
  }

  bool get realisticData => getRealisticData();

  void setRealisticData(bool value) {
    prefs.setBool("realisticData", value);
  }
}
