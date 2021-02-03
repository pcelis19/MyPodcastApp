import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/audio_player_related/play_pause_widget.dart';
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
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.network(audioPlayer
                    .currentEpisode.partialPodcastInformation.imageUrl),
              ),
            ),
            Expanded(
              child: Placeholder(),
            ),
            Expanded(
              child: Placeholder(),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Placeholder()),
                  Expanded(child: PlayPauseButton()),
                  Expanded(child: Placeholder())
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
