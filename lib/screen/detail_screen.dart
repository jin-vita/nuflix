import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/app_data.dart';
import '../widget/nu_appbar.dart';
import '../widget/nu_detail_large.dart';
import '../widget/nu_detail_small.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppData data = Get.find();
    data.setDetail(id: data.program.id);
    data.clicked.value =
        data.prefs.getStringList('like')!.contains(data.program.id)
            ? true
            : false;

    onHeartTap() async {
      final liked = data.prefs.getStringList('like')!;
      if (liked.contains(data.program.id)) {
        liked.remove(data.program.id);
        data.clicked.value = false;
      } else {
        liked.add(data.program.id);
        data.clicked.value = true;
      }
      await data.prefs.setStringList('like', liked);

      data.heartPrograms.value.clear();
      for (var program in data.programs) {
        if (data.prefs.getStringList('like')!.contains(program.id)) {
          data.heartPrograms.value.add(program);
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NuAppBar(
        title: data.program.title,
        hasIcon: true,
        actions: [
          Obx(
            () => IconButton(
              onPressed: onHeartTap,
              icon: Icon(
                data.clicked.value ? Icons.favorite : Icons.favorite_outline,
              ),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          Get.find<AppData>().update();
          Get.back();
          return Future.value(false);
          // return Future(() => false);
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
