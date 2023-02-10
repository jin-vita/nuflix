import 'package:flutter/material.dart';
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
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
