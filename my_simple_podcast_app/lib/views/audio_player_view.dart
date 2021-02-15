import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/models/episode.dart';
import 'package:my_simple_podcast_app/services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/widgets/play_pause_widget.dart';
import 'package:my_simple_podcast_app/widgets/seek_widgets.dart';
import 'package:sprintf/sprintf.dart';

class PlayerHomeScreen extends StatelessWidget {
  const PlayerHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer _audioPlayer = AudioPlayer();
    TextTheme textDesign = Theme.of(context).textTheme;
    return StreamBuilder<RealtimePlayingInfos>(
      stream: _audioPlayer.realtimePlayingInfos,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          Metas metas = snapshot.data.current.audio.audio.metas;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.network(metas.image.path),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          metas.album,
                          style: textDesign.headline6,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          metas.title,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: AudioPlayerSlider(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: BackTenSeconds()),
                      Expanded(child: PlayPauseButton()),
                      Expanded(child: ForwardTenSeconds())
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class AudioPlayerSlider extends StatelessWidget {
  const AudioPlayerSlider({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();
    return StreamBuilder<RealtimePlayingInfos>(
      stream: _audioPlayer.realtimePlayingInfos,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        int _seconds = snapshot.data.currentPosition.inSeconds;
        String _label = label(_seconds);
        String _maxLabel = label(snapshot.data.duration.inSeconds);
        // AudioPlayer audioPlayer = context.watch<AudioPlayer>();
        return Column(
          children: [
            Slider(
              min: 0,
              max: snapshot.data.duration.inSeconds.toDouble(),
              label: _label,
              divisions: 200,
              value: _seconds.toDouble(),
              onChanged: (seekValue) {
                Duration to = Duration(seconds: seekValue.floor());
                _audioPlayer.seek(to);
              },
            ),
            Text("${_label} / ${_maxLabel}")
          ],
        );
      },
    );
  }

  String label(int seconds) {
    int hours = (seconds / 3600).floor();
    seconds = seconds - hours * 3600;
    int minutes = (seconds / 60).floor();
    seconds = seconds - minutes * 60;
    return sprintf("%02i:%02i:%02i", [hours, minutes, seconds]);
  }
}
