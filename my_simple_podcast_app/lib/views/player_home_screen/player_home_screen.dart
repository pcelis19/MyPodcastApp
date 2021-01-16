import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:provider/provider.dart';

class PlayerHomeScreen extends StatelessWidget {
  const PlayerHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(builder: (context, audioPlayer, child) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 5,
              child: Placeholder(),
            ),
            Expanded(
              child: Placeholder(),
            ),
            Expanded(
              child: Placeholder(),
            ),
            Expanded(
              child: Placeholder(),
            ),
          ],
        ),
      );
    });
  }
}
