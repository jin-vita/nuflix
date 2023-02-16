import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/app_data.dart';
import '../util/util.dart';
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
    Util.showYesNoDialog(
      title: '로그아웃 할까요?',
      noText: '아니오',
      onNoPressed: () => Get.back(),
      yesText: '예',
      onYesPressed: () {
        Get.find<AppData>().prefs.setString('userName', '');
        Get.offAllNamed('/login');
      },
    );
    return Future.value(true);
  }
}
