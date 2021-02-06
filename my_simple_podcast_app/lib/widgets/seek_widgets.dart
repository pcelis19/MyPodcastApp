import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/services/audio_player/audio_player.dart';

class BackTenSeconds extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.replay_10),
      onPressed: _audioPlayer.rewindTenSeconds,
    );
  }
}

class ForwardTenSeconds extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.forward_10),
      onPressed: _audioPlayer.forwardTenSeconds,
    );
  }
}
