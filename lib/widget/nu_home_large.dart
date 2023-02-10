import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuflix/model/episode_model.dart';
import 'package:nuflix/screen/heart_screen.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../model/program_model.dart';
import '../screen/detail_screen.dart';
import 'nu_episode.dart';
import 'nu_thumb_card.dart';

class NuHomeLarge extends StatelessWidget {
  const NuHomeLarge({
    super.key,
    required this.isHeart,
  });

  final bool isHeart;

  @override
  Widget build(BuildContext context) {
    Data data = Provider.of(context);

    Future<void> goDetailScreen(
        BuildContext context, ProgramModel program) async {
      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DetailScreen(
            program: program,
            prefs: data.prefs,
          ),
          fullscreenDialog: true,
        ),
      );
      data.applyData();
    }

    List<ProgramModel> myPrograms = [];
    for (var program in data.programs) {
      if (data.prefs.getStringList('like')!.contains(program.id)) {
        myPrograms.add(program);
      }
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            isHeart && myPrograms.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: const Text('즐겨찾기한 프로그램이 없습니다.'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var program in isHeart ? myPrograms : data.programs)
                        GestureDetector(
                          onTap: () async {
                            await goDetailScreen(context, program);
                          },
                          child: Column(
                            children: [
                              NuThumbCard(
                                program: program,
                                height: 300,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                program.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
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
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 350,
                      child: data.prefs.getString('id') == null
                          ? const Center(child: Text('최근 본 영상이 없습니다.'))
                          : NuEpisode(
                              episode: EpisodeModel(
                                title: data.prefs.getString('title')!,
                                id: data.prefs.getString('id')!,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: ProgressBar(
                        thumbColor: Colors.green,
                        baseBarColor: Colors.green.withOpacity(0.3),
                        progressBarColor: Colors.green,
                        progress: Duration(
                          milliseconds: data.prefs.getInt('progress') ?? 0,
                        ),
                        total: const Duration(minutes: 80),
                        onSeek: (percent) {
                          data.prefs.setInt('progress', percent.inMilliseconds);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
                const SizedBox(),
                Visibility(
                  visible: !isHeart,
                  child: Column(
                    children: [
                      const Text(
                        '즐겨찾기',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          data.prefs.getStringList('like')!.isEmpty
                              ? Fluttertoast.showToast(msg: '즐겨찾기한 프로그램이 없습니다.')
                              : Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => HeartScreen(
                                      programs: data.programs,
                                      prefs: data.prefs,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
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
                            color: Colors.green,
                          ),
                        ),
                        iconSize: 100,
                      ),
                    ],
                  ),
                ),
                const SizedBox(),
                const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
