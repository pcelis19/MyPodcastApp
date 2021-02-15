import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_constants/route_names.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:my_simple_podcast_app/views/player_home_screen/player_home_screen.dart';
import 'package:provider/provider.dart';

import 'play_pause_widget.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(
      builder: (context, audioPlayer, child) {
        SizeConfig().init(context);

        String title = 'LET\'S START LISTENING!';

        Widget leading = Icon(Icons.error_outline);

        Widget trailing = Icon(Icons.error_outline);

        if (audioPlayer.currentEpisode != null) {
          leading = Image.network(
              audioPlayer.currentEpisode.partialPodcastInformation.imageUrl);
          title = audioPlayer.currentEpisode.episodeName;
          trailing = PlayPauseButton();
        }

        return FlatButton(
          onPressed: audioPlayer.currentEpisode != null
              ? () => Navigator.of(context).pushNamed(kAudioPlayerView)
              : null,
          child: Container(
            height: SizeConfig.screenHeight * .11,
            width: double.infinity,
            child: Center(
              child: ListTile(
                leading: leading,
                title: Text(title),
                trailing: trailing,
              ),
            ),
          ),
        );
      },
    );
  }
}
