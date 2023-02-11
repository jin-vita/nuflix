import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  // $ flutter pub add url_launcher
  // $ flutter pub add fluttertoast
  // $ flutter pub add audio_video_progress_bar
  // $ flutter pub add provider
  // $ flutter pub add get
  @override
  Widget build(BuildContext context) {
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

    return FutureBuilder(
      future: initPrefs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => Data(
                  prefs: snapshot.data!,
                ),
              ),
            ],
            child: const MaterialApp(
              home: HomeScreen(),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
