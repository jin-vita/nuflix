import 'package:flutter/material.dart';

import '../model/detail_model.dart';
import '../model/episode_model.dart';
import '../model/program_model.dart';
import 'nu_episode.dart';
import 'nu_thumb_card.dart';

class NuDetailLarge extends StatelessWidget {
  const NuDetailLarge({
    super.key,
    required this.program,
    required this.detail,
    required this.episodes,
  });

  final ProgramModel program;
  final DetailModel detail;
  final List<EpisodeModel> episodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NuThumbCard(
              program: program,
              height: 300,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${detail.birth}  |  ${detail.genre}',
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              detail.about,
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
            for (var episode in episodes)
              NuEpisode(
                episode: episode,
              ),
          ],
        ),
      ],
    );
  }
}
