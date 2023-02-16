import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/app_data.dart';
import 'nu_episode.dart';
import 'nu_thumb_card.dart';

class NuDetailSmall extends StatelessWidget {
  const NuDetailSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppData data = Get.find();
    return Column(
      children: [
        NuThumbCard(
          program: data.program,
          height: 400,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data.detail.birth}  |  ${data.detail.genre}',
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              data.detail.about,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            for (var episode in data.episodes)
              NuEpisode(
                episode: episode,
              ),
          ],
        ),
      ],
    );
  }
}
