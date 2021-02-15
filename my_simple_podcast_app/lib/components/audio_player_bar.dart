import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/hero_identifiers.dart';
import 'package:my_simple_podcast_app/constants/route_names.dart';
import 'package:my_simple_podcast_app/models/episode.dart';
import 'package:my_simple_podcast_app/services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/widgets/play_pause_widget.dart';

class AudioPlayerBar extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<RealtimePlayingInfos>(
          stream: _audioPlayer.realtimePlayingInfos,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ListTile(
                leading: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                title: const Text("Let\'s start listening!"),
              );
            } else {
              Metas metas = snapshot.data.current.audio.audio.metas;
              return FlatButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(kAudioPlayerView),
                child: ListTile(
                  leading: Image.network(metas.image.path),
                  title: Text(metas.title),
                  trailing: PlayPauseButton(),
                ),
              );
            }
          }),
    );
  }
}
