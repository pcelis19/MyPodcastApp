import 'dart:async';
import 'dart:developer';

import 'package:my_simple_podcast_app/global_models/podcast.dart';

import 'shared_preferences_service.dart';

class FavoritePodcastsService {
  static final FavoritePodcastsService _favoritesPodcastsService =
      FavoritePodcastsService.internal();
  factory FavoritePodcastsService() {
    return _favoritesPodcastsService;
  }
  StreamController<List<Podcast>> _streamController =
      StreamController<List<Podcast>>.broadcast();
  FavoritePodcastsService.internal();
  List<Podcast> _favoritePodcasts = [];
  bool _loadedFavorites = false;

  /// this returns a stream of podcast shows because podcast shows may be added and deleted, therefore
  /// we have to continue to listen to this stream
  Stream<List<Podcast>> get favoritePodcasts {
    return _streamController.stream;
  }

  Future<bool> isFavorite(Podcast podcast) async {
    await _intializeFavorites();
    return _favoritePodcasts.contains(podcast);
  }

  Future<void> removePodcastFromFavorites(Podcast podcast) async {
    await _intializeFavorites();
    if (_favoritePodcasts.contains(podcast)) {
      _favoritePodcasts.remove(podcast);
      _streamController.add(_favoritePodcasts);
      SharedPreferencesService().removePodcast(podcast);
    }
  }

  Future<void> addPodcastToFavorites(Podcast podcast) async {
    await _intializeFavorites();
    if (!_favoritePodcasts.contains(podcast)) {
      _favoritePodcasts.add(podcast);
      _streamController.add(_favoritePodcasts);
      SharedPreferencesService().addPodcast(podcast);
    }
  }

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$Private Functions$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// receives a List<Map<String, dynamic>> that will unpack
  /// each json file and return a List<Podcast>
  List<Podcast> _unpackJsonPodcast(List<Map<String, dynamic>> jsonPodcasts) {
    List<Podcast> unpackedPodcasts = [];
    for (Map<String, dynamic> jsonPodcast in jsonPodcasts) {
      Podcast unpackedPodcast = Podcast(
          podcastId: jsonPodcast[PODCAST_ID],
          artistName: jsonPodcast[ARTIST_NAME],
          showName: jsonPodcast[SHOW_NAME],
          imageUrl: jsonPodcast[SHOW_NAME],
          feedUrl: jsonPodcast[SHOW_NAME],
          releaseDate: jsonPodcast[SHOW_NAME],
          contentAdvisoryRating: jsonPodcast[SHOW_NAME],
          country: jsonPodcast[SHOW_NAME],
          genres: jsonPodcast[SHOW_NAME]);
      unpackedPodcasts.add(unpackedPodcast);
    }
    return unpackedPodcasts;
  }

  /// make sure that things
  /// are intialized
  Future<void> _intializeFavorites() async {
    // no need to redo this intensive work over and over
    if (!_loadedFavorites) {
      try {
        List<Map<String, dynamic>> jsonPodcasts =
            await SharedPreferencesService().favoritePodcasts;

        _favoritePodcasts =
            jsonPodcasts == null ? [] : _unpackJsonPodcast(jsonPodcasts);
        _loadedFavorites = true;
        _streamController.add(_favoritePodcasts);
      } catch (e) {
        log("[ERROR: SharedPreferencesService().favoritePodcasts]: ${e.toString()}");
        _loadedFavorites = false;
      }
    }
  }
}
