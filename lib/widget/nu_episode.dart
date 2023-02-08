import 'package:flutter/material.dart';
import 'package:nuflix/model/episode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NuEpisode extends StatefulWidget {
  const NuEpisode({
    super.key,
    required this.episode,
    required this.id,
  });

  final EpisodeModel episode;
  final String id;

  @override
  State<NuEpisode> createState() => _NuEpisodeState();
}

class _NuEpisodeState extends State<NuEpisode> {
  onButtonTap() async {
    // $ flutter pub add url_launcher
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final liked = prefs.getStringList('like');
    if (!liked!.contains(widget.id)) {
      liked.add(widget.id);
      await prefs.setStringList('like', liked);
    }
    final url =
        Uri.parse('https://noonoo27.tv/old_entertainment/${widget.episode.id}');
    await launchUrl(url);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.episode.title,
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
