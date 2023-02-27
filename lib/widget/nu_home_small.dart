import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/app_data.dart';
import '../model/model_program.dart';
import '../util/util.dart';
import 'nu_episode.dart';
import 'nu_program.dart';

class NuHomeSmall extends StatelessWidget {
  const NuHomeSmall({
    super.key,
    required this.isHeart,
  });

  final bool isHeart;

  @override
  Widget build(BuildContext context) {
    AppData data = Get.find();

    List<ProgramModel> myPrograms = [];
    for (var program in data.programs) {
      if (data.prefs.getStringList('like')!.contains(program.id)) {
        myPrograms.add(program);
      }
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
        ),
        child: Column(
          children: [
            GetBuilder<AppData>(
              builder: (_) {
                return isHeart && data.heartPrograms.call().isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        height: 300,
                        child: const Text('즐겨찾기한 프로그램이 없습니다.'),
                      )
                    : SizedBox(
                        height: 360,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          itemCount: isHeart
                              ? myPrograms.length
                              : data.programs.length,
                          itemBuilder: (context, index) {
                            var program = isHeart
                                ? myPrograms[index]
                                : data.programs[index];
                            return NuProgram(program: program);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 30),
                        ),
                      );
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Column(
                children: [
                  const Text(
                    '최근 본 영상 시청',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.cyan,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => SizedBox(
                      width: 350,
                      child: data.episode.value.id == ''
                          ? const Center(child: Text('최근 본 영상이 없습니다.'))
                          : NuEpisode(episode: data.episode.value),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    child: GetBuilder<AppData>(builder: (context) {
                      return ProgressBar(
                        thumbColor: Colors.cyan,
                        baseBarColor: Colors.cyan.withOpacity(0.3),
                        progressBarColor: Colors.cyan,
                        progress: Duration(
                          milliseconds: data.prefs.getInt('progress') ?? 0,
                        ),
                        total: const Duration(minutes: 80),
                        onSeek: (percent) {
                          data.prefs.setInt('progress', percent.inMilliseconds);
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '다음회 영상 시청',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.cyan,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => SizedBox(
                      width: 350,
                      child: data.episode.value.id == ''
                          ? const SizedBox()
                          : NuEpisode(episode: data.nextEpisode.value),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Visibility(
                    visible: !isHeart,
                    child: Column(
                      children: [
                        const Text(
                          '즐겨찾기',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.cyan,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            data.prefs.getStringList('like')!.isEmpty
                                ? Util.showSnackBar(
                                    message: '즐겨찾기한 프로그램이 없습니다.')
                                : Get.toNamed('/heart');
                          },
                          icon: const Icon(
                            Icons.folder_special,
                            color: Colors.cyan,
                          ),
                          iconSize: 90,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        '영상이 안보일때 클릭',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.cyan,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showUrlDialog(context, data.prefs);
                        },
                        icon: Icon(
                          Icons.network_check_rounded,
                          shadows: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(10, 10),
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                          color: Colors.cyan,
                        ),
                        iconSize: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showUrlDialog(BuildContext context, SharedPreferences prefs) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            '업데이트 할까요?',
            style: TextStyle(
              color: Colors.cyan,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  prefs.setInt(
                    'urlNumber',
                    prefs.getInt('urlNumber')! + 1,
                  );
                  Get.back();
                  Util.showSnackBar(message: '사이트 주소를 이전으로 돌렸습니다.');
                },
                child: const Text(
                  '업데이트',
                  style: TextStyle(
                    color: Colors.cyan,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  prefs.setInt(
                    'urlNumber',
                    prefs.getInt('urlNumber')! - 1,
                  );
                  Get.back();
                  Util.showSnackBar(message: '사이트 주소를 이전으로 돌렸습니다.');
                },
                child: const Text(
                  '되돌리기',
                  style: TextStyle(
                    color: Colors.cyan,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
