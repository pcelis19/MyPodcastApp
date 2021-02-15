import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/services/audio_player/audio_player.dart';

class CurrentTrackTitle extends StatelessWidget {
  const CurrentTrackTitle({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();
    return StreamBuilder<RealtimePlayingInfos>(
        stream: _audioPlayer.realtimePlayingInfos,
        builder: (context, snapshot) {
          String title;
          if (!snapshot.hasData) {
            title = '';
          } else {
            title = snapshot.data.current.audio.audio.metas.title;
          }
          return AutoSizeText(
            title,
            maxLines: 2,
          );
        });
  }
}
