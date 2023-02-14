import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nuflix/model/episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/app_data.dart';

class NuEpisode extends StatelessWidget {
  const NuEpisode({
    super.key,
    required this.episode,
  });

  final EpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    AppData data = Get.find();
    onButtonTap() async {
      if (data.prefs.getString('id') == episode.id) {
        final time = Duration(milliseconds: data.prefs.getInt('progress') ?? 0);
        Fluttertoast.showToast(msg: '이전 종료 시점 : ${'$time'.split('.').first}');
      } else {
        data.prefs.setInt('progress', 0);
        Fluttertoast.showToast(msg: '새로운 영상을 시작합니다.');
      }
      await data.prefs.setString('id', episode.id);
      await data.prefs.setString('title', episode.title);
      final url = Uri.parse(
          'https://noonoo${data.prefs.getInt('urlNumber')}.tv/old_entertainment/${episode.id}');
      await launchUrl(url);
    }

    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(10, 10),
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  episode.title,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 17,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
