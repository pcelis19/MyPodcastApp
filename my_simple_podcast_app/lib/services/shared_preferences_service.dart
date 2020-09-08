import 'dart:convert';

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

  SharedPreferences _sharedPreferences;

  /// ensures that [_sharedPreferences] is initialized
  /// this should be called at the beginning of every function
  /// dealing with loading from cache
  Future<void> _initializeSharedPreferences() async {
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns List<String>
  Future<List<String>> get previousSearchTerms async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForPreviousSearchTerms)) {
      return null;
    }
    String cachedData =
        _sharedPreferences.getString(_keyForPreviousSearchTerms);
    List<String> savedData = jsonDecode(cachedData)[_keyForPreviousSearchTerms];
    return savedData;
  }

  /// adds [searchTerm] to cache
  /// * if cache exists
  /// ** adds [searchTerm] to cache
  /// * else
  /// ** creates a [List<String>]
  /// ** maps list to [_keyForPreviousSearchTerms]
  /// ** saves map to cache
  ///
  Future<void> addSearchTerm(String searchTerm) async {
    await _initializeSharedPreferences();
    if (!_sharedPreferences.containsKey(_keyForPreviousSearchTerms)) {
      List<String> starterList = List<String>();
      _saveListOfSearchTermsToCache(starterList);
    }
    String cachedData =
        _sharedPreferences.getString(_keyForPreviousSearchTerms);
    List<String> savedData = jsonDecode(cachedData)[_keyForPreviousSearchTerms];
    if (savedData.contains(searchTerm)) {
      savedData.remove(searchTerm);
    }
    // add term at the top of the list
    savedData.insert(0, searchTerm);
    _saveListOfSearchTermsToCache(savedData);
  }

  /// saves previous search terms [List<String] to cache
  Future<void> _saveListOfSearchTermsToCache(
      List<String> previousSearchTerms) async {
    await _initializeSharedPreferences();
    Map<String, dynamic> jsonData = {
      _keyForPreviousSearchTerms: previousSearchTerms
    };
    String jsonString = jsonEncode(jsonData);
    _sharedPreferences.setString(_keyForPreviousSearchTerms, jsonString);
  }
}