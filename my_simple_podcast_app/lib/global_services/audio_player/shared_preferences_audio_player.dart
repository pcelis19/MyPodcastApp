import 'dart:convert';
import 'dart:developer';

import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerSharedPreferencesService {
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Establishing Singleton $$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// internal object that is returned
  static final AudioPlayerSharedPreferencesService
      _audioSharedPreferencesService =
      AudioPlayerSharedPreferencesService._internal();
  AudioPlayerSharedPreferencesService._internal();

  /// returns the static object
  factory AudioPlayerSharedPreferencesService() {
    return _audioSharedPreferencesService;
  }
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Private Members $$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// acts as the key for saved objects
  final String _keyForAudioPlayer = 'audioPlayer';

  /// internal shared preferences, houses all the cache data
  SharedPreferences _sharedPreferences;

  /// ensures that [_sharedPreferences] is initialized
  /// this should be called at the beginning of every function
  /// dealing with loading from cache
  Future<void> _initializeSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  /// updates the cache, with the ram's current audio player
  Future<void> updateAudioToCache(AudioPlayer audioPlayer) async {
    await _initializeSharedPreferences();
    if (_sharedPreferences.containsKey(_keyForAudioPlayer))
      await _sharedPreferences.remove(_keyForAudioPlayer);
    // new list that will be saved to cache
    Map<String, dynamic> jsonData = Map<String, dynamic>();
    //populate audio with the new audio
    jsonData[kAudioPlayer] = audioPlayer.toJson();
    // adding the mapping, to create jsonData

    String jsonString = jsonEncode(jsonData);
    log("[SAVE_CACHED_DATA]$jsonString");
    _sharedPreferences.setString(_keyForAudioPlayer, jsonString);
  }

  /// This should be used on app load up
  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns json data of audio player
  Future<Map<String, dynamic>> get packedAudioPlayer async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForAudioPlayer)) {
      log("Key doesn't exist, returned null");
      return null;
    }
    String cachedData = _sharedPreferences.getString(_keyForAudioPlayer);
    log("[LOAD_CACHED_DATA] $cachedData");
    return jsonDecode(cachedData)[_keyForAudioPlayer];
  }
}
