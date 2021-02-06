import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/services/audio_player/audio_player.dart';

class PlayPauseButton extends StatefulWidget {
  PlayPauseButton({Key key}) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _audioPlayer.isPlaying,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return Icon(Icons.play_disabled);
        } else {
          bool isPlaying = snapshot.data;
          return IconButton(
              iconSize: 50,
              onPressed: () => isPlaying
                  ? _audioPlayer.pauseEpisode
                  : _audioPlayer.playEpisode,
              icon: Icon(isPlaying
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded));
        }
      },
    );
  }
}
