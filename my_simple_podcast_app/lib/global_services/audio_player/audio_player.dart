import 'dart:convert';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_simple_podcast_app/global_models/episode.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player_constants.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_shared_preferences.dart';

/// Singleton object
class AudioPlayer with ChangeNotifier {
  ///internal static object
  static final AudioPlayer _audioPlayer = AudioPlayer.internal();

  //internal static object for shared preferences
  static final AudioPlayerSharedPreferencesService
      _audioPlayerSharedPreferencesService =
      AudioPlayerSharedPreferencesService();

  /// internal player
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  /// keeps track of the current audio being played
  Episode _currentEpisode;

  /// checks if the Audio Player has been loaded
  bool _loadedAudioPlayer = false;

  /// returns a reference to the internal audio player
  factory AudioPlayer() {
    return _audioPlayer;
  }

  AudioPlayer.internal();

  /// destroys audio player
  @override
  void dispose() {
    // TODO: implement dispose
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  /// returns the current episode being played
  Episode get currentEpisode {
    return _currentEpisode;
  }

  Future<void> playNextEpisode(Episode nextEpisode) async {
    Audio audio = _getAudio(nextEpisode);
    await _assetsAudioPlayer.open(audio);

    // if the nextEpisode is loaded properly then updated the information and cache it
    //TODO update share preferences
    _audioPlayerSharedPreferencesService.updateAudioToCache(_audioPlayer);
    _currentEpisode = nextEpisode;

    notifyListeners();
  }

  AudioPlayer.fromJson(Map<String, dynamic> jsonData) {
    log("[AudioPlayer.fromJson]: ${jsonData.toString()}");
    _currentEpisode = Episode.fromJson(jsonData);
    Audio audio = _getAudio(_currentEpisode);
    Duration previousLocation =
        Duration(seconds: int.parse(jsonData[kCurrentLocation]));
    _loadEpisode(audio, previousLocation);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {
      kCurrentEpisode: currentEpisode.toJson(),
      kCurrentLocation: _assetsAudioPlayer.currentPosition.value.inSeconds,
    };
    log("[AudioPlayer.toJson]: ${jsonData.toString()}");

    return jsonData;
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

  Future<void> _loadEpisode(Audio audio, Duration duration) async {
    await _assetsAudioPlayer.open(audio);
    _assetsAudioPlayer.seek(duration);

    _assetsAudioPlayer.pause();
  }

  /// make sure that things
  /// are intialized
  Future<void> intializeAudioPlayer() async {
    // no need to redo this intensive work over and over
    if (!_loadedAudioPlayer) {
      try {
        Map<String, dynamic> jsonData =
            await _audioPlayerSharedPreferencesService.packedAudioPlayer;
        if (jsonData != null) {
          AudioPlayer.fromJson(jsonData);
        }
        _loadedAudioPlayer = true;
        notifyListeners();
      } catch (e) {
        log("[ERROR: AudioSharedPreferences().packedAudioPlayer]: ${e.toString()}");
        _loadedAudioPlayer = false;
      }
    }
  }
}
