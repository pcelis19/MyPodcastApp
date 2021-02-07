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
      child: StreamBuilder<Episode>(
          stream: _audioPlayer.currentEpisode,
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
              Episode currentEpisode = snapshot.data;
              return FlatButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(kAudioPlayerView),
                child: ListTile(
                  leading: Image.network(
                      currentEpisode.partialPodcastInformation.imageUrl),
                  title: Text(currentEpisode.episodeName),
                  trailing:
                      Hero(tag: kHeroPlayPauseButton, child: PlayPauseButton()),
                ),
              );
            }
          }),
    );
  }
}
