import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuflix/data/app_data.dart';
import 'package:nuflix/screen/login_screen.dart';

import '../widget/nu_appbar.dart';
import '../widget/nu_home_large.dart';
import '../widget/nu_home_small.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.isHeart = false});

  final bool isHeart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NuAppBar(
        hasIcon: true,
        // isHeart ? true : false,
        title: isHeart
            ? '대탈출 즐겨찾기'
            : '${Get.find<AppData>().prefs.getString('userName')}님 환영합니다!',
      ),
      body: WillPopScope(
        onWillPop: () {
          return isHeart ? back(context) : exit(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: MediaQuery.of(context).size.width > 960
                    ? NuHomeLarge(isHeart: isHeart)
                    : NuHomeSmall(isHeart: isHeart),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> back(BuildContext context) {
    Get.find<AppData>().update();
    return Future.value(true);
  }

  Future<bool> exit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              '로그아웃 할까요?',
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
                    Get.find<AppData>().prefs.setString('userName', '');
                    Get.offAll(const LoginScreen());
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
                    // Navigator.pop(context, false);
                    Get.back();
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
      },
    );
    return Future(() => false);
  }
}
