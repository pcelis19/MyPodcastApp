import 'dart:convert';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_simple_podcast_app/global_models/episode.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player_constants.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/shared_preferences_audio_player.dart';

/// [AudioPlayer] is a Singleton object
class AudioPlayer with ChangeNotifier {
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Members $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  ///internal static object
  static final AudioPlayer _audioPlayer = AudioPlayer.internal();

  /// internal player
  static final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  /// keeps track of the current audio being played
  Episode _currentEpisode;

  /// checks if the Audio Player has been loaded
  bool _loadedAudioPlayer = false;

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Private Functions $$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

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
    super.dispose();
  }

  /// returns the current episode being played
  Episode get currentEpisode {
    return _audioPlayer._currentEpisode;
  }

  /// make sure that things
  /// are intialized
  Future<void> intializeAudioPlayer() async {
    // no need to redo this intensive work over and over
    if (!_loadedAudioPlayer) {
      // try {
      Map<String, dynamic> jsonData =
          await AudioPlayerSharedPreferencesService().packedAudioPlayer;
      // if there is something in the cache, then load the audio player,
      // just let the AudioPlayer to act like a new player
      if (jsonData != null) {
        AudioPlayer.fromJson(jsonData);
      }
      _loadedAudioPlayer = true;
      notifyListeners();
    }
  }

  /// creates a AudioPlayer from json file
  AudioPlayer.fromJson(Map<String, dynamic> jsonData) {
    log("[AudioPlayer.fromJson]: ${jsonEncode(jsonData)}");

    _audioPlayer._currentEpisode = Episode.fromJson(jsonData[kCurrentEpisode]);

    Audio audio = _getAudio(_audioPlayer._currentEpisode);
    Duration previousLocation =
        Duration(seconds: int.parse(jsonData[kCurrentLocation].toString()));
    _loadEpisode(audio, previousLocation);
  }

  /// creates json data from an AudioPlayer
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {
      kCurrentEpisode: currentEpisode.toJson(),
      kCurrentLocation: _assetsAudioPlayer.currentPosition.value.inSeconds,
    };
    log("[AudioPlayer.toJson]: ${jsonEncode(jsonData.toString())}");

    return jsonData;
  }

  /// plays the next episode
  Future<void> playNextEpisode(Episode nextEpisode) async {
    Audio audio = _getAudio(nextEpisode);
    await _assetsAudioPlayer.open(audio);
    _audioPlayer._currentEpisode = nextEpisode;
    // if the nextEpisode is loaded properly then updated the information and cache it
    //TODO update share preferences
    await AudioPlayerSharedPreferencesService()
        .updateAudioToCache(_audioPlayer);

    notifyListeners();
  }

  Future<void> playEpisode() async {
    await _assetsAudioPlayer.play();
    notifyListeners();
  }

  /// will pause the current episode
  Future<void> pauseEpisode() async {
    await _assetsAudioPlayer.pause();
    await AudioPlayerSharedPreferencesService()
        .updateAudioToCache(_audioPlayer);
    notifyListeners();
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

  /// returns a stream of current playing information
  Stream<RealtimePlayingInfos> get realtimePlayingInfos =>
      _assetsAudioPlayer.realtimePlayingInfos;

  /// returns a stream if something current being played
  Stream<bool> get isPlaying => _assetsAudioPlayer.isPlaying;
}
