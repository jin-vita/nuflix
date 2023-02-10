import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/program_model.dart';

class Data extends ChangeNotifier {
  List<ProgramModel> programs;
  SharedPreferences prefs;
  Data({
    required this.programs,
    required this.prefs,
  });

  Future<SharedPreferences> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('like') == null) {
      await prefs.setStringList('like', []);
    }
    return prefs;
  }

  void setData({
    programs,
  }) {
    this.programs = programs;
  }

  void applyData() {
    notifyListeners();
  }
}
