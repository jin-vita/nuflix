import 'package:flutter/material.dart';

import '../model/detail_model.dart';
import '../model/episode_model.dart';
import '../model/program_model.dart';
import 'nu_episode.dart';
import 'nu_thumb_card.dart';

class NuDetailSmall extends StatelessWidget {
  const NuDetailSmall({
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NuThumbCard(
              program: program,
              height: 130,
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${detail.birth}  |  ${detail.genre}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    detail.about,
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
                      episode: episodes[i],
                      id: program.id,
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
                  for (int i = 6; i < episodes.length; i++)
                    NuEpisode(
                      episode: episodes[i],
                      id: program.id,
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
