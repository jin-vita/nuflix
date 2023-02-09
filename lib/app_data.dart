import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends InheritedWidget {
  const AppData({
    super.key,
    required this.prefs,
    required super.child,
  });

  final SharedPreferences prefs;

  static AppData of(BuildContext context) {
    final AppData? result =
        context.dependOnInheritedWidgetOfExactType<AppData>();
    assert(result != null, 'No AppData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppData oldWidget) {
    return prefs != oldWidget.prefs;
  }
}
