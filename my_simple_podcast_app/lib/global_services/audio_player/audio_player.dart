import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_simple_podcast_app/global_models/episode.dart';

/// Singleton object
class AudioPlayer with ChangeNotifier {
  ///internal static object
  static final AudioPlayer _audioPlayer = AudioPlayer.internal();

  /// internal player
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  /// keeps track of the current audio being played
  Episode _currentEpisode;

  /// returns a reference to the internal audio player
  factory AudioPlayer() {
    return _audioPlayer;
  }

  AudioPlayer.internal();

  /// destroys audio player
  @override
  void dispose() {
    // TODO: implement dispose
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  /// returns the current episode being played
  Episode get currentEpisode {
    return _currentEpisode;
  }

  Future<void> playNextEpisode(Episode nextEpisode) async {
    await _assetsAudioPlayer.open(
      Audio.network(
        nextEpisode.audioSourceUrl,
        metas: Metas(
            title: nextEpisode.episodeName,
            artist: nextEpisode.partialPodcastInformation.artistName,
            album: nextEpisode.partialPodcastInformation.podcastName,
            image: MetasImage.network(
                nextEpisode.partialPodcastInformation.imageUrl)),
      ),
    );
    // if the nextEpisode is loaded properly then updated the information
    _currentEpisode = nextEpisode;

    notifyListeners();
  }

  Future<void> playEpisode() async {
    await _assetsAudioPlayer.play();
    notifyListeners();
  }

  Future<void> pauseEpisode() async {
    await _assetsAudioPlayer.pause();
    notifyListeners();
  }

  Stream<bool> get isPlaying {
    return _assetsAudioPlayer.isPlaying;
  }
}
