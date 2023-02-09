import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/program_model.dart';
import '../widget/nu_appbar.dart';
import '../widget/nu_home_large.dart';
import '../widget/nu_home_small.dart';

class HeartScreen extends StatefulWidget {
  const HeartScreen({
    super.key,
    required this.prefs,
    required this.programs,
  });

  final SharedPreferences prefs;
  final List<ProgramModel> programs;

  @override
  State<HeartScreen> createState() => _HeartScreenState();
}

class _HeartScreenState extends State<HeartScreen> {
  @override
  Widget build(BuildContext context) {
    final List<ProgramModel> myPrograms = [];
    for (var program in widget.programs) {
      if (widget.prefs.getStringList('like')!.contains(program.id)) {
        myPrograms.add(program);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const NuAppBar(
        hasIcon: true,
        title: '대탈출 즐겨찾기',
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
              child: MediaQuery.of(context).size.width > 960
                  ? NuHomeLarge(
                      programs: myPrograms,
                      prefs: widget.prefs,
                      isHeart: true,
                    )
                  : NuHomeSmall(
                      programs: myPrograms,
                      prefs: widget.prefs,
                      isHeart: true,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
