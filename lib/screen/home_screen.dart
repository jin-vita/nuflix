import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nuflix/widget/nu_appbar.dart';
import '../widget/nu_home_large.dart';
import '../widget/nu_home_small.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const NuAppBar(
        hasIcon: false,
        title: '누 플 릭 스',
      ),
      body: WillPopScope(
        onWillPop: () {
          return exit2(context);
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
                child: MediaQuery.of(context).size.width > 960
                    ? const NuHomeLarge(
                        isHeart: false,
                      )
                    : const NuHomeSmall(
                        isHeart: false,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> exit2(BuildContext context) async {
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
