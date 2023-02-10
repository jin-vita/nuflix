import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../model/episode_model.dart';
import '../model/program_model.dart';
import '../screen/detail_screen.dart';
import '../screen/heart_screen.dart';
import 'nu_episode.dart';
import 'nu_thumb_card.dart';

class NuHomeSmall extends StatelessWidget {
  const NuHomeSmall({
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
      child: Column(
        children: [
          isHeart && myPrograms.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: 300,
                  child: const Text('즐겨찾기한 프로그램이 없습니다.'),
                )
              : SizedBox(
                  height: 370,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    itemCount:
                        isHeart ? myPrograms.length : data.programs.length,
                    itemBuilder: (context, index) {
                      var program =
                          isHeart ? myPrograms[index] : data.programs[index];
                      return GestureDetector(
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
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 30,
                    ),
                  ),
                ),
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
                height: 30,
              ),
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
                      icon: const Icon(
                        Icons.folder_special,
                        color: Colors.green,
                      ),
                      iconSize: 90,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
