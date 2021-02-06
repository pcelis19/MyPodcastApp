import 'dart:convert';

import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
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
  List<PartialPodcastInformation> favoritePartialInfoPodcasts = [];

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Private Functions $$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// ensures that [_sharedPreferences] is initialized
  /// this should be called at the beginning of every function
  /// dealing with loading from cache
  Future<void> _initializeSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  /// if local cache does not exist, then it creates a cache
  Future<void> _guarenteeCache() async {
    // this seems redudant, added here if in the future, other
    // functions may be deleted.
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForFavoritePodcasts)) {
      List<PartialPodcastInformation> starterList = [];
      await updateListOfFavoritePodcastsToCache(starterList);
    }
  }

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$ Public Functions $$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns List<Podcasts> (list of shows)
  Future<List<PartialPodcastInformation>> get unpackedFavoritePodcasts async {
    await _initializeSharedPreferences();
    await _guarenteeCache();
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    //log(cachedData);
    List<Map<String, dynamic>> packedPodcasts = List<Map<String, dynamic>>.from(
        jsonDecode(cachedData)[_keyForFavoritePodcasts]);
    List<PartialPodcastInformation> unpackedPodcasts = [];
    for (Map<String, dynamic> packedPodcast in packedPodcasts)
      unpackedPodcasts.add(PartialPodcastInformation.fromJson(packedPodcast));
    return unpackedPodcasts;
  }

  /// updates the cache, with the ram's favorites
  Future<void> updateListOfFavoritePodcastsToCache(
      List<PartialPodcastInformation> updatedList) async {
    await _initializeSharedPreferences();
    await _sharedPreferences.remove(_keyForFavoritePodcasts);
    // new list that will be saved to cache
    List<Map<String, dynamic>> newSetOfPackedFavoritedPodcasts =
        List<Map<String, dynamic>>();
    // populating the json formatted podcasts with the updated list
    updatedList.forEach(
        (element) => newSetOfPackedFavoritedPodcasts.add(element.toJson()));
    // adding the mapping, to create jsonData
    Map<String, dynamic> jsonData = {
      _keyForFavoritePodcasts: newSetOfPackedFavoritedPodcasts
    };
    String jsonString = jsonEncode(jsonData);
    _sharedPreferences.setString(_keyForFavoritePodcasts, jsonString);
  }
}
