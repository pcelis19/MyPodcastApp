import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/models/episode.dart';
import 'package:my_simple_podcast_app/services/audio_player/audio_player.dart';

class CurrentTrackTitle extends StatelessWidget {
  const CurrentTrackTitle({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();
    return StreamBuilder<Episode>(
        stream: _audioPlayer.currentEpisode,
        builder: (context, snapshot) {
          String title;
          if (!snapshot.hasData) {
            title = '';
          } else {
            title = snapshot.data.episodeName;
          }
          return AutoSizeText(
            title,
            maxLines: 2,
          );
        });
  }
}
