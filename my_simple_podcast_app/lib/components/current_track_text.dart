import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:provider/provider.dart';

class CurrentTrackTitle extends StatelessWidget {
  const CurrentTrackTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(
      builder: (context, audioPlayer, child) {
        String title = audioPlayer.currentEpisode != null
            ? audioPlayer.currentEpisode.episodeName
            : '';
        return AutoSizeText(
          title,
          maxLines: 2,
        );
      },
    );
  }
}
