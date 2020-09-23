import 'dart:convert';
import 'dart:developer';

import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePodcastsSharedPreferencesService {
  //Creation of singleton
  static final FavoritePodcastsSharedPreferencesService
      _sharedPreferencesService =
      FavoritePodcastsSharedPreferencesService._internal();
  FavoritePodcastsSharedPreferencesService._internal();
  factory FavoritePodcastsSharedPreferencesService() {
    return _sharedPreferencesService;
  }

  final String _keyForFavoritePodcasts = 'favoriteShows';
  SharedPreferences _sharedPreferences;

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns List<dynamic> (list of shows)
  Future<List<dynamic>> get unpackedFavoritePodcasts async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForFavoritePodcasts)) {
      List<dynamic> starterList = List<dynamic>();
      _saveListOfFavoritePodcastsToCache(starterList);
      return null;
    }
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);

    List<dynamic> savedData = jsonDecode(cachedData)[_keyForFavoritePodcasts];
    return savedData;
  }

  /// adds [podcast] to cache
  /// * if cache exists
  /// ** adds [podcast] to cache
  /// * else
  /// ** creates a [List<Map<String,dynamic>]
  /// ** maps list to [_keyForFavorites]
  /// ** saves map to cache
  ///
  ///
  /*
  TODO: https://stackoverflow.com/questions/61316208/how-to-save-listobject-to-sharedpreferences-flutter
You should do these steps

to save the object:

convert your object to map
encode your map to string
save the string to shared preferences
for restoring your object:

decode shared preference string to a map
use fromJson() method to get your Music object
  */
  Future<void> addPodcast(Podcast podcast) async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForFavoritePodcasts)) {
      List<dynamic> starterList = List<dynamic>();
      _saveListOfFavoritePodcastsToCache(starterList);
    }
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    List<dynamic> savedData = jsonDecode(cachedData)[_keyForFavoritePodcasts];

    // add term at the top of the list
    savedData.insert(0, podcast.toJsonObject);
    List<Map<String, dynamic>> packedJsonData = [];
    for (dynamic item in savedData) {}
    _saveListOfFavoritePodcastsToCache(savedData);
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
    if (!_sharedPreferences.containsKey(_keyForFavoritePodcasts)) {
      List<dynamic> starterList = List<dynamic>();
      _saveListOfFavoritePodcastsToCache(starterList);
    }
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    List<dynamic> savedData = jsonDecode(cachedData)[_keyForFavoritePodcasts];

    // add term at the top of the list
    savedData.remove(podcast.toJsonObject);
    _saveListOfFavoritePodcastsToCache(savedData);
  }

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$Private Functions$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// ensures that [_sharedPreferences] is initialized
  /// this should be called at the beginning of every function
  /// dealing with loading from cache
  Future<void> _initializeSharedPreferences() async {
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _saveListOfFavoritePodcastsToCache(
      List<Map<String, dynamic>> packedFavoritedPodcasts) async {
    await _initializeSharedPreferences();
    Map<String, dynamic> jsonData = {
      _keyForFavoritePodcasts: packedFavoritedPodcasts
    };
    String jsonString = jsonEncode(jsonData);
    _sharedPreferences.setString(_keyForFavoritePodcasts, jsonString);
  }
}
