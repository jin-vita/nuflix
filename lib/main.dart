import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/app_data.dart';
import 'screen/home_screen.dart';

void main() {
  initController;
  runApp(const MyApp());
}

final initController = Get.put(AppData());

// $ flutter pub add url_launcher
// $ flutter pub add fluttertoast
// $ flutter pub add audio_video_progress_bar
// $ flutter pub add provider
// $ flutter pub add get
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initPrefs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppData data = Get.find();
          data.prefs = snapshot.data!;
          return const GetMaterialApp(
            home: HomeScreen(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<SharedPreferences> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 설정 정보 초기화
    if (prefs.getStringList('like') == null) {
      await prefs.setStringList('like', []);
    }
    if (prefs.getInt('urlNumber') == null) {
      await prefs.setInt('urlNumber', 27);
    }
    return prefs;
  }
}
