import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/audio_player_related/play_pause_widget.dart';
import 'package:my_simple_podcast_app/global_components/audio_player_related/seek_widgets.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

class PlayerHomeScreen extends StatelessWidget {
  const PlayerHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(builder: (context, audioPlayer, child) {
      TextTheme textDesign = Theme.of(context).textTheme;
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.network(audioPlayer
                    .currentEpisode.partialPodcastInformation.imageUrl),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    audioPlayer
                        .currentEpisode.partialPodcastInformation.podcastName,
                    style: textDesign.headline6,
                  ),
                  Text(audioPlayer.currentEpisode.episodeName)
                ],
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
    });
  }
}

class AudioPlayerSlider extends StatelessWidget {
  const AudioPlayerSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(builder: (context, audioPlayer, child) {
      return StreamBuilder<RealtimePlayingInfos>(
        stream: audioPlayer.realtimePlayingInfos,
        builder: (context, snapshot) {
          int _seconds = snapshot.data.currentPosition.inSeconds;
          String _label = label(_seconds);
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
                  audioPlayer.seek(to);
                },
              ),
              Text(_label)
            ],
          );
        },
      );
    });
  }

  String label(int seconds) {
    int hours = (seconds / 3600).floor();
    seconds = seconds - hours * 3600;
    int minutes = (seconds / 60).floor();
    seconds = seconds - minutes * 60;
    return sprintf("%02i:%02i:%02i", [hours, minutes, seconds]);
  }
}
