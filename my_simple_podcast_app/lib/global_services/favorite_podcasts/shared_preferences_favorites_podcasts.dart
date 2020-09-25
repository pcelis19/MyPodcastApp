import 'dart:convert';
import 'dart:developer';

import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePodcastsSharedPreferencesService {
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Establishing Singleton $$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// internal object that is returned
  static final FavoritePodcastsSharedPreferencesService
      _sharedPreferencesService =
      FavoritePodcastsSharedPreferencesService._internal();
  FavoritePodcastsSharedPreferencesService._internal();

  /// returns the static object
  factory FavoritePodcastsSharedPreferencesService() {
    return _sharedPreferencesService;
  }
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Private Members $$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// acts as the key for saved objects
  final String _keyForFavoritePodcasts = 'favoriteShows';

  /// internal shared preferences, houses all the cache data
  SharedPreferences _sharedPreferences;

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Public Members $$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// List of favorited shows
  List<Podcast> favoritePodcasts = [];

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Private Functions $$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// ensures that [_sharedPreferences] is initialized
  /// this should be called at the beginning of every function
  /// dealing with loading from cache
  Future<void> _initializeSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      if (!_sharedPreferences.containsKey(_keyForFavoritePodcasts)) {
        List<Map<String, dynamic>> starterList = List<Map<String, dynamic>>();
        await _updateListOfFavoritePodcastsToCache(starterList);
      }
    }
  }

  Future<void> _updateListOfFavoritePodcastsToCache(
      List<Map<String, dynamic>> packedFavoritedPodcasts) async {
    Map<String, dynamic> jsonData = {
      _keyForFavoritePodcasts: packedFavoritedPodcasts
    };
    String jsonString = jsonEncode(jsonData);
    _sharedPreferences.setString(_keyForFavoritePodcasts, jsonString);
  }

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Public Functions $$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns List<Podcasts> (list of shows)
  Future<List<Podcast>> get unpackedFavoritePodcasts async {
    await _initializeSharedPreferences();
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    log(cachedData);
    List<Map<String, dynamic>> packedPodcasts = List<Map<String, dynamic>>.from(
        jsonDecode(cachedData)[_keyForFavoritePodcasts]);
    List<Podcast> unpackedPodcasts = [];
    for (Map<String, dynamic> packedPodcast in packedPodcasts)
      unpackedPodcasts.add(Podcast.fromJson(packedPodcast));
    return unpackedPodcasts;
  }

  /// adds [podcast] to cache
  /// * if cache exists
  /// ** adds [podcast] to cache
  /// * else
  /// ** creates a [List<Map<String,dynamic>]
  /// ** maps list to [_keyForFavorites]
  /// ** saves map to cache
  Future<void> addPodcast(Podcast podcast) async {
    await _initializeSharedPreferences();
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    List<Map<String, dynamic>> savedData = List<Map<String, dynamic>>.from(
        jsonDecode(cachedData)[_keyForFavoritePodcasts]);

    // add term at the top of the list
    savedData.insert(0, podcast.toJson());
    List<Map<String, dynamic>> packedJsonData = [];
    for (dynamic item in savedData) {}
    _updateListOfFavoritePodcastsToCache(savedData);
  }

  /// removes [podcast] to cache
  /// * if cache exists
  /// ** removes [podcast] to cache
  /// * else
  /// ** creates a [List<Map<String,dynamic>]
  /// ** maps list to [_keyForFavorites]
  /// ** saves map to cache
  ///
  Future<void> removePodcast(Podcast podcast) async {
    await _initializeSharedPreferences();
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    List<Map<String, dynamic>> savedData = List<Map<String, dynamic>>.from(
        jsonDecode(cachedData)[_keyForFavoritePodcasts]);

    // add term at the top of the list
    savedData.remove(podcast.toJson());
    _updateListOfFavoritePodcastsToCache(savedData);
  }
}
