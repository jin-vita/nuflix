import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/app_data.dart';
import '../model/program_model.dart';
import '../widget/nu_appbar.dart';
import '../widget/nu_detail_large.dart';
import '../widget/nu_detail_small.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.program,
  });

  final ProgramModel program;

  @override
  Widget build(BuildContext context) {
    AppData data = Get.find();
    data.setProgram(program: program);
    data.setDetail(id: program.id);

    onHeartTap() async {
      final liked = data.prefs.getStringList('like');
      if (liked != null) {
        if (liked.contains(program.id)) {
          liked.remove(program.id);
        } else {
          liked.add(program.id);
        }
        await data.prefs.setStringList('like', liked);
      }
      data.update();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NuAppBar(
        title: program.title,
        hasIcon: true,
        action: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              data.prefs.getStringList('like')!.contains(program.id)
                  ? Icons.favorite
                  : Icons.favorite_outline,
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, 'back');
          return Future(() => false);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: MediaQuery.of(context).size.width > 960
                ? const NuDetailSmall()
                : const NuDetailLarge(),
          ),
        ),
      ),
    );
  }
}
