import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuflix/model/episode_model.dart';
import 'package:nuflix/screen/heart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/program_model.dart';
import '../screen/detail_screen.dart';
import 'nu_episode.dart';
import 'nu_thumb_card.dart';

class NuHomeLarge extends StatefulWidget {
  const NuHomeLarge({
    super.key,
    required this.programs,
    required this.prefs,
    required this.isHeart,
  });

  final List<ProgramModel> programs;
  final SharedPreferences prefs;
  final bool isHeart;

  @override
  State<NuHomeLarge> createState() => _NuHomeLargeState();
}

class _NuHomeLargeState extends State<NuHomeLarge> {
  @override
  Widget build(BuildContext context) {
    final EpisodeModel episode = EpisodeModel(
      title: widget.prefs.getString('title') ?? '',
      id: widget.prefs.getString('id') ?? '',
    );

    List<ProgramModel> myPrograms = [];
    for (var program in widget.programs) {
      if (widget.prefs.getStringList('like')!.contains(program.id)) {
        myPrograms.add(program);
      }
    }

    Future<void> goDetailScreen(
        BuildContext context, ProgramModel program) async {
      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DetailScreen(
            program: program,
            prefs: widget.prefs,
            isHeart: widget.isHeart,
          ),
          fullscreenDialog: true,
        ),
      );
      try {
        setState(() {});
      } catch (_) {}
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            widget.isHeart && myPrograms.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: const Text('즐겨찾기한 프로그램이 없습니다.'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var program
                          in widget.isHeart ? myPrograms : widget.programs)
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
                      child: episode.id == ''
                          ? const Center(child: Text('최근 본 영상이 없습니다.'))
                          : NuEpisode(
                              episode: episode,
                            ),
                    ),
                  ],
                ),
                const SizedBox(),
                const SizedBox(),
                Visibility(
                  visible: !widget.isHeart,
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
                          widget.prefs.getStringList('like')!.isEmpty
                              ? Fluttertoast.showToast(msg: '즐겨찾기한 프로그램이 없습니다.')
                              : Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => HeartScreen(
                                      programs: widget.programs,
                                      prefs: widget.prefs,
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
