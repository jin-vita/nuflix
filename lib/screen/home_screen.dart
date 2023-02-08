import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nuflix/widget/nu_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/program_model.dart';
import '../widget/nu_home_large.dart';
import '../widget/nu_home_small.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ProgramModel> programs = [
    ProgramModel(title: '대탈출 시즌1', thumb: 'big1.jpg', id: 'eoxkfcnf1'),
    ProgramModel(title: '대탈출 시즌2', thumb: 'big2.jpg', id: 'eoxkfcnf2'),
    ProgramModel(title: '대탈출 시즌3', thumb: 'big3.jpg', id: 'eoxkfcnf3'),
    ProgramModel(title: '대탈출 시즌4', thumb: 'big4.jpg', id: 'eoxkfcnf4'),
  ];

  late Future<SharedPreferences> prefsFuture;

  Future<SharedPreferences> initPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('like') == null) {
      await prefs.setStringList('like', []);
    }
    return prefs;
  }

  @override
  void initState() {
    super.initState();
    prefsFuture = initPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const NuAppBar(
          title: '대탈출 다시보기',
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: FutureBuilder(
                  future: prefsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MediaQuery.of(context).size.width > 959
                          ? NuHomeLarge(
                              programs: programs, prefs: snapshot.data!)
                          : NuHomeSmall(
                              programs: programs, prefs: snapshot.data!);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
