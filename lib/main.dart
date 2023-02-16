import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nuflix/model/episode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/app_data.dart';
import 'screen/detail_screen.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';

void main() {
  initController;
  runApp(const MyApp());
}

final log = Logger();
final initController = Get.put(AppData());

// flutter pub add url_launcher
// flutter pub add fluttertoast
// flutter pub add audio_video_progress_bar
// flutter pub add get
// flutter pub add dio
// flutter pub add logger
// flutter pub add animated_login (login_screen.dart)
// flutter pub add async (CancelableOperation)
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
          initData(data);

          return GetMaterialApp(
            initialRoute:
                data.prefs.getString('userName') == '' ? '/login' : '/home',
            getPages: [
              GetPage(
                name: '/login',
                page: () => const LoginScreen(),
                transition: Transition.rightToLeft,
              ),
              GetPage(
                name: '/home',
                page: () => const HomeScreen(),
                transition: Transition.circularReveal,
              ),
              GetPage(
                  name: '/heart',
                  page: () => const HomeScreen(isHeart: true),
                  transition: Transition.fadeIn),
              GetPage(
                name: '/detail',
                page: () => const DetailScreen(),
                transition: Transition.circularReveal,
                transitionDuration: const Duration(milliseconds: 450),
              ),
            ],
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
    if (prefs.getString('userName') == null) {
      await prefs.setString('userName', '');
    }
    return prefs;
  }

  void initData(AppData data) {
    data.progress = (data.prefs.getInt('progress') ?? 0).obs;
    data.episode = EpisodeModel(
            title: data.prefs.getString('title') ?? '',
            id: data.prefs.getString('id') ?? '')
        .obs;
    for (var program in data.programs) {
      if (data.prefs.getStringList('like')!.contains(program.id)) {
        data.heartPrograms.value.add(program);
      }
    }
  }
}
