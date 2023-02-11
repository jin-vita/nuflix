import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data.dart';
import '../model/episode_model.dart';
import '../model/program_model.dart';
import '../screen/heart_screen.dart';
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
    Data data = Provider.of(context);

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
                      return NuProgram(program: program);
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
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  const Text(
                    '영상이 안보일때 클릭',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.green,
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
                      color: Colors.green,
                    ),
                    iconSize: 90,
                  ),
                ],
              ),
            ],
          ),
        ],
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
                  prefs.setInt(
                    'urlNumber',
                    prefs.getInt('urlNumber')! + 1,
                  );
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: '사이트 주소가 업데이트 되었습니다.');
                },
                child: const Text(
                  '업데이트',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  prefs.setInt(
                    'urlNumber',
                    prefs.getInt('urlNumber')! - 1,
                  );
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: '사이트 주소를 이전으로 돌렸습니다.');
                },
                child: const Text(
                  '되돌리기',
                  style: TextStyle(
                    color: Colors.green,
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
