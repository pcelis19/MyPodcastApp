import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:provider/provider.dart';

class BackTenSeconds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(
      builder: (context, audioPlayer, child) {
        return IconButton(
            icon: Icon(Icons.replay_10),
            onPressed: audioPlayer.rewindTenSeconds);
      },
    );
  }
}

class ForwardTenSeconds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(
      builder: (context, audioPlayer, child) {
        return IconButton(
            icon: Icon(Icons.forward_10),
            onPressed: audioPlayer.forwardTenSeconds);
      },
    );
  }
}
