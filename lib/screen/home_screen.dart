import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    // ignore: unused_local_variable
    DateTime? currentBackPressTime;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const NuAppBar(
        hasIcon: false,
        title: '누 플 릭 스',
      ),
      body: WillPopScope(
        onWillPop: () {
          return exit2();
        },
        child: Column(
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
                      return MediaQuery.of(context).size.width > 960
                          ? NuHomeLarge(
                              programs: programs,
                              prefs: snapshot.data!,
                              isHeart: false,
                            )
                          : NuHomeSmall(
                              programs: programs,
                              prefs: snapshot.data!,
                              isHeart: false,
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> exit1(DateTime? currentBackPressTime) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      const msg = "'뒤로'버튼을 한 번 더 누르면 종료됩니다.";

      Fluttertoast.showToast(msg: msg);
      return Future(() => false);
    }
    return Future(() => true);
  }

  Future<bool> exit2() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                '그만볼래요?',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      //onWillpop에 true가 전달되어 앱이 종료 된다.
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      '네',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                      Navigator.pop(context, false);
                    },
                    child: const Text(
                      '아니요',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
