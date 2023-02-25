import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/app_data.dart';
import '../util/util.dart';
import 'nu_episode.dart';
import 'nu_program.dart';

class NuHomeLarge extends StatelessWidget {
  const NuHomeLarge({
    super.key,
    required this.isHeart,
  });

  final bool isHeart;

  @override
  Widget build(BuildContext context) {
    AppData data = Get.find();

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          children: [
            GetBuilder<AppData>(
              builder: (_) {
                return SizedBox(
                  child: isHeart && data.heartPrograms.call().isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          height: 300,
                          child: const Text('즐겨찾기한 프로그램이 없습니다.'),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var program in isHeart
                                ? data.heartPrograms.call()
                                : data.programs)
                              NuProgram(program: program),
                          ],
                        ),
                );
              },
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    const Text(
                      '최근 본 영상 시청',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.cyan,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => SizedBox(
                        width: 350,
                        child: data.episode.value.id == ''
                            ? const Center(child: Text('최근 본 영상이 없습니다.'))
                            : NuEpisode(
                                episode: data.episode.value,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: GetBuilder<AppData>(
                        builder: (con) {
                          return ProgressBar(
                            thumbColor: Colors.cyan,
                            baseBarColor: Colors.cyan.withOpacity(0.3),
                            progressBarColor: Colors.cyan,
                            progress: Duration(
                              milliseconds: data.prefs.getInt('progress') ?? 0,
                            ),
                            total: const Duration(minutes: 80),
                            onSeek: (percent) {
                              data.prefs
                                  .setInt('progress', percent.inMilliseconds);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '다음회 영상 시청',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.cyan,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => SizedBox(
                        width: 350,
                        child: data.episode.value.id == ''
                            ? const SizedBox()
                            : NuEpisode(episode: data.nextEpisode.value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          data.prefs.getStringList('like')!.isEmpty
                              ? Util.showSnackBar(message: '즐겨찾기한 프로그램이 없습니다.')
                              : Get.toNamed('/heart');
                        },
                        icon: Transform.scale(
                          scale: 1.5,
                          child: Icon(
                            Icons.folder_special,
                            shadows: [
                              BoxShadow(
                                blurRadius: 15,
                                offset: const Offset(10, 10),
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                            color: Colors.cyan,
                          ),
                        ),
                        iconSize: 100,
                      ),
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
                    const SizedBox(
                      height: 15,
                    ),
                    IconButton(
                      onPressed: () {
                        showUrlDialog(context, data.prefs);
                      },
                      icon: Transform.scale(
                        scale: 1.5,
                        child: Icon(
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
                      ),
                      iconSize: 100,
                    ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showUrlDialog(BuildContext context, SharedPreferences prefs) {
    Util.showYesNoDialog(
      title: '업데이트 할까요?',
      noText: '되돌리기',
      onNoPressed: () {
        prefs.setInt(
          'urlNumber',
          prefs.getInt('urlNumber')! - 1,
        );
        Get.back();
        Util.showSnackBar(message: '사이트 주소를 이전으로 돌렸습니다.');
      },
      yesText: '업데이트',
      onYesPressed: () {
        prefs.setInt(
          'urlNumber',
          prefs.getInt('urlNumber')! + 1,
        );
        Get.back();
        Util.showSnackBar(message: '사이트 주소가 업데이트 되었습니다.');
      },
    );
    return Future.value(true);
  }
}
