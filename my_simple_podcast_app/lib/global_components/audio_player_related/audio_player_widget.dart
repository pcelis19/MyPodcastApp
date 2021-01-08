import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:provider/provider.dart';

import 'play_pause_widget.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(
      builder: (context, audioPlayer, child) {
        SizeConfig().init(context);
        String title = audioPlayer.currentEpisode != null
            ? audioPlayer.currentEpisode.episodeName
            : '';
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: audioPlayer.currentEpisode != null
              ? SizeConfig.screenHeight * .11
              : 0,
          width: double.infinity,
          child: Center(
            child: ListTile(
              title: Text(title),
              trailing: PlayPauseButton(),
            ),
          ),
        );
      },
    );
  }
}
