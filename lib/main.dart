import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';
import 'model/program_model.dart';
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
  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> initPrefs() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getStringList('like') == null) {
        await prefs.setStringList('like', []);
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
                  programs: [
                    ProgramModel(
                      title: '대탈출 시즌1',
                      thumb: 'big1.jpg',
                      id: 'eoxkfcnf1',
                    ),
                    ProgramModel(
                      title: '대탈출 시즌2',
                      thumb: 'big2.jpg',
                      id: 'eoxkfcnf2',
                    ),
                    ProgramModel(
                      title: '대탈출 시즌3',
                      thumb: 'big3.jpg',
                      id: 'eoxkfcnf3',
                    ),
                    ProgramModel(
                      title: '대탈출 시즌4',
                      thumb: 'big4.jpg',
                      id: 'eoxkfcnf4',
                    ),
                  ],
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
