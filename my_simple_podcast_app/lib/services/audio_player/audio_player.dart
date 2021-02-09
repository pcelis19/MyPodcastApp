import 'dart:async';
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:my_simple_podcast_app/models/episode.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_player_constants.dart';
import 'shared_preferences_audio_player.dart';

/// [AudioPlayer] is a Singleton object
class AudioPlayer {
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Members $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  ///internal static object
  static final AudioPlayer _audioPlayer = AudioPlayer.internal();

  /// internal player
  static final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  /// keeps track of the current audio being played
  final StreamController<Episode> _currentEpisodeController =
      BehaviorSubject<Episode>();

  /// checks if the Audio Player has been loaded
  bool _loadedAudioPlayer = false;

  /// current episode updated by the stream controller
  Episode _currentEpisode;

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Public Functions $$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// returns a reference to the internal audio player
  factory AudioPlayer() {
    return _audioPlayer;
  }
  AudioPlayer.internal();

  /// destroys audio player
  @override
  void dispose() async {
    // TODO: implement dispose
    await pauseEpisode();
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
    _currentEpisodeController.close();
  }

  // GETTERS

  /// returns the current episode being played
  Stream<Episode> get currentEpisode {
    return _currentEpisodeController.stream;
  }

  /// returns a stream of current playing information
  Stream<RealtimePlayingInfos> get realtimePlayingInfos =>
      _assetsAudioPlayer.realtimePlayingInfos;

  /// returns a stream if something current being played
  Stream<bool> get isPlaying => _assetsAudioPlayer.isPlaying;

  /// make sure that things
  /// are intialized
  Future<void> intializeAudioPlayer() async {
    // no need to redo this intensive work over and over
    if (!_loadedAudioPlayer) {
      // try {
      Map<String, dynamic> jsonData =
          await AudioPlayerSharedPreferencesService().packedAudioPlayer;

      /// if there is something in the cache and the user has listen to something
      ///(which fill the map), then load the audio player,
      if (jsonData != null && jsonData[kCurrentEpisode] != null) {
        AudioPlayer.fromJson(jsonData);
      }
      _loadedAudioPlayer = true;
      _listenToEpisodeChanges();
    }
  }

  /// creates a AudioPlayer from json file
  AudioPlayer.fromJson(Map<String, dynamic> jsonData) {
    log(jsonData.toString());
    Episode loadedEpisode = Episode.fromJson(jsonData[kCurrentEpisode]);
    _currentEpisodeController.sink.add(loadedEpisode);
    Audio audio = _getAudio(loadedEpisode);
    Duration previousLocation =
        Duration(seconds: int.parse(jsonData[kCurrentLocation].toString()));
    _loadEpisode(audio, previousLocation);
  }

  /// creates json data from an AudioPlayer
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {
      kCurrentEpisode: _currentEpisode,
      kCurrentLocation: _assetsAudioPlayer.currentPosition.value.inSeconds,
    };
    // log("[AudioPlayer.toJson]: ${jsonEncode(jsonData.toString())}");

    return jsonData;
  }

  /// plays the next episode
  Future<void> playNextEpisode(Episode nextEpisode) async {
    if (_currentEpisode == nextEpisode) return;
    Audio audio = _getAudio(nextEpisode);
    await _assetsAudioPlayer.open(audio);
    _updateAudio(nextEpisode);
    // if the nextEpisode is loaded properly then updated the information and cache it
    //TODO update share preferences
    await AudioPlayerSharedPreferencesService()
        .updateAudioToCache(_audioPlayer);
  }

  Future<void> playEpisode() async {
    await _assetsAudioPlayer.play();
  }

  /// will pause the current episode
  Future<void> pauseEpisode() async {
    await _assetsAudioPlayer.pause();
    await AudioPlayerSharedPreferencesService()
        .updateAudioToCache(_audioPlayer);
  }

  /// the player will go rewind 10 seconds
  Future<void> rewindTenSeconds() async {
    _assetsAudioPlayer.seekBy(const Duration(seconds: -10));
  }

  /// the player will go forward 10 seconds
  Future<void> forwardTenSeconds() async {
    _assetsAudioPlayer.seekBy(const Duration(seconds: 10));
  }

  Future<void> seek(Duration to) async {
    await _assetsAudioPlayer.seek(to);
    await AudioPlayerSharedPreferencesService()
        .updateAudioToCache(_audioPlayer);
  }

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Private Functions $$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// Will load an episode, and go to the desired location
  Future<void> _loadEpisode(Audio audio, Duration duration) async {
    await _assetsAudioPlayer.open(audio);
    _assetsAudioPlayer.seek(duration);
    _assetsAudioPlayer.pause();
  }

  Audio _getAudio(Episode episode) {
    return Audio.network(
      episode.audioSourceUrl,
      metas: Metas(
          title: episode.episodeName,
          artist: episode.partialPodcastInformation.artistName,
          album: episode.partialPodcastInformation.podcastName,
          image:
              MetasImage.network(episode.partialPodcastInformation.imageUrl)),
    );
  }

  void _listenToEpisodeChanges() {
    _currentEpisodeController.stream.listen(
      (Episode nextEpisode) {
        _currentEpisode = nextEpisode;
      },
    );
  }

  void _updateAudio(Episode nextEpisode) {
    _currentEpisodeController.sink.add(nextEpisode);
  }
}
