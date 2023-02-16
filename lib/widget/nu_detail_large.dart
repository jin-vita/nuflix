import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/app_data.dart';
import 'nu_episode.dart';
import 'nu_thumb_card.dart';

class NuDetailLarge extends StatelessWidget {
  const NuDetailLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppData data = Get.find();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NuThumbCard(
              program: data.program,
              height: 130,
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data.detail.birth}  |  ${data.detail.genre}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.detail.about,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                children: [
                  for (int i = 0; i < 6; i++)
                    NuEpisode(
                      episode: data.episodes[i],
                    ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Flexible(
              child: Column(
                children: [
                  for (int i = 6; i < data.episodes.length; i++)
                    NuEpisode(
                      episode: data.episodes[i],
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
