import 'dart:convert';

import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  //Creation of singleton
  static final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService._internal();
  SharedPreferencesService._internal();
  factory SharedPreferencesService() {
    return _sharedPreferencesService;
  }

  final String _keyForPreviousSearchTerms = 'searchTerms';
  final String _keyForFavoritePodcasts = 'favoriteShows';
  SharedPreferences _sharedPreferences;

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns List<Map<String, dynamic>> (list of shows)
  Future<List<Map<String, dynamic>>> get favoritePodcasts async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForFavoritePodcasts)) {
      return null;
    }
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    List<Map<String, dynamic>> savedData =
        jsonDecode(cachedData)[_keyForFavoritePodcasts];
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
  Future<void> addPodcast(Podcast podcast) async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForFavoritePodcasts)) {
      List<Map<String, dynamic>> starterList = List<Map<String, dynamic>>();
      _saveListOfSearchTermsToCache(starterList);
    }
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    List<Map<String, dynamic>> savedData =
        jsonDecode(cachedData)[_keyForFavoritePodcasts];

    // add term at the top of the list
    savedData.insert(0, podcast.toJsonObject);
    _saveListOfSearchTermsToCache(savedData);
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
      List<Map<String, dynamic>> starterList = List<Map<String, dynamic>>();
      _saveListOfSearchTermsToCache(starterList);
    }
    String cachedData = _sharedPreferences.getString(_keyForFavoritePodcasts);
    List<Map<String, dynamic>> savedData =
        jsonDecode(cachedData)[_keyForFavoritePodcasts];

    // add term at the top of the list
    savedData.remove(podcast.toJsonObject);
    _saveListOfSearchTermsToCache(savedData);
  }

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns List<dynamic>
  Future<List<dynamic>> get previousSearchTerms async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForPreviousSearchTerms)) {
      return null;
    }
    String cachedData =
        _sharedPreferences.getString(_keyForPreviousSearchTerms);
    List<dynamic> savedData =
        jsonDecode(cachedData)[_keyForPreviousSearchTerms];
    return savedData;
  }

  /// adds [searchTerm] to cache
  /// * if cache exists
  /// ** adds [searchTerm] to cache
  /// * else
  /// ** creates a [List<dynamic>]
  /// ** maps list to [_keyForPreviousSearchTerms]
  /// ** saves map to cache
  ///
  Future<void> addSearchTerm(String searchTerm) async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForPreviousSearchTerms)) {
      List<dynamic> starterList = List<dynamic>();
      _saveListOfSearchTermsToCache(starterList);
    }
    String cachedData =
        _sharedPreferences.getString(_keyForPreviousSearchTerms);
    List<dynamic> savedData =
        jsonDecode(cachedData)[_keyForPreviousSearchTerms];
    if (savedData.contains(searchTerm)) {
      savedData.remove(searchTerm);
    }
    // add term at the top of the list
    savedData.insert(0, searchTerm);
    _saveListOfSearchTermsToCache(savedData);
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

  /// saves previous search terms [List<dynamic] to cache
  Future<void> _saveListOfSearchTermsToCache(
      List<dynamic> previousSearchTerms) async {
    await _initializeSharedPreferences();
    Map<String, dynamic> jsonData = {
      _keyForPreviousSearchTerms: previousSearchTerms
    };
    String jsonString = jsonEncode(jsonData);
    _sharedPreferences.setString(_keyForPreviousSearchTerms, jsonString);
  }
}
