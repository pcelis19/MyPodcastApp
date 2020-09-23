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
  StreamController<List<Podcast>> streamController =
      StreamController<List<Podcast>>.broadcast();
  FavoritePodcastsService.internal();
  List<Podcast> _favoritePodcasts = [];

  /// make sure that things
  /// are intialized
  Future<void> intializeFavorites() async {
    try {
      List<Map<String, dynamic>> jsonPodcasts =
          await SharedPreferencesService().favoritePodcasts;

      _favoritePodcasts =
          jsonPodcasts == null ? [] : _unpackJsonPodcast(jsonPodcasts);
      streamController.add(_favoritePodcasts);
    } catch (e) {
      log("[ERROR: SharedPreferencesService().favoritePodcasts]: ${e.toString()}");
    }
  }

  /// this returns a stream of podcast shows because podcast shows may be added and deleted, therefore
  /// we have to continue to listen to this stream
  Stream<List<Podcast>> get favoritePodcasts {
    return streamController.stream;
  }

  bool isFavorite(Podcast podcast) {
    return _favoritePodcasts.contains(podcast);
  }
  // Future<void> addFavoriteShow(Podcast podcast) {}
  // Future<void> removeFavoriteShow(Podcast podcast) {}

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
}
