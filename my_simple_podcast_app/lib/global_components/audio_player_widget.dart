import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:provider/provider.dart';

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

class PlayPauseButton extends StatefulWidget {
  PlayPauseButton({Key key}) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayer>(
      builder: (context, audioPlayer, child) {
        return StreamBuilder<bool>(
          stream: audioPlayer.isPlaying,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == null) return Icon(Icons.play_disabled);
            bool isPlaying = snapshot.data;
            return IconButton(
              iconSize: 50,
              onPressed: () => isPlaying
                  ? audioPlayer.pauseEpisode()
                  : audioPlayer.playEpisode(),
              icon: Icon(isPlaying
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded),
            );
          },
        );
      },
    );
  }
}
