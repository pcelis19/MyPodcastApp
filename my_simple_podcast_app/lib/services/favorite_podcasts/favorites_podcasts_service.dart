import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';

import 'shared_preferences_favorites_podcasts.dart';

/// This handles the services that the UI will see, but hides
/// any interactions with the cache. Saving to cache takes longer
/// than saving to ram. So we will update the ram portion first, and
/// take care of the saving to cache in the background
class FavoritePodcastsService with ChangeNotifier {
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Members $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  static final FavoritePodcastsService _favoritesPodcastsService =
      FavoritePodcastsService.internal();

  /// this is the list of podcasts saved to RAM
  List<PartialPodcastInformation> _favoritePodcasts = [];

  /// internal boolean, so that when initializing  the class we
  /// do not do redudant work
  bool _loadedFavorites = false;

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Private Functions $$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Public Functions $$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// make sure that things
  /// are intialized
  Future<void> intializeFavorites() async {
    // no need to redo this intensive work over and over
    if (!_loadedFavorites) {
      try {
        List<PartialPodcastInformation> unpackedPodcasts =
            await FavoritePodcastsSharedPreferencesService()
                .unpackedFavoritePodcasts;

        _favoritePodcasts = unpackedPodcasts == null ? [] : unpackedPodcasts;
        _loadedFavorites = true;
        notifyListeners();
      } catch (e) {
        log("[ERROR: FavoritePodcastsSharedPreferencesService().favoritePodcasts]: ${e.toString()}");
        _loadedFavorites = false;
      }
    }
  }

  factory FavoritePodcastsService() {
    return _favoritesPodcastsService;
  }
  FavoritePodcastsService.internal();

  /// this returns a stream of podcast shows because podcast shows may be added and deleted, therefore
  /// we have to continue to listen to this stream
  List<PartialPodcastInformation> get favoritePodcasts {
    return _favoritePodcasts;
  }

  /// checks if a podcast is a favorited podcast
  bool isPodcastFavorite(PartialPodcastInformation podcast) {
    return _favoritePodcasts.contains(podcast);
  }

  /// removes podcast from favorites
  Future<void> removePodcastFromFavorites(
      PartialPodcastInformation podcast) async {
    await intializeFavorites();
    if (_favoritePodcasts.contains(podcast)) {
      _favoritePodcasts.remove(podcast);
      notifyListeners(); // remove from cache
      FavoritePodcastsSharedPreferencesService()
          .updateListOfFavoritePodcastsToCache(_favoritePodcasts);
    }
  }

  /// adds podcast to favorites
  Future<void> addPodcastToFavorites(PartialPodcastInformation podcast) async {
    await intializeFavorites();
    if (!_favoritePodcasts.contains(podcast)) {
      _favoritePodcasts.add(podcast);
      notifyListeners();
      FavoritePodcastsSharedPreferencesService()
          .updateListOfFavoritePodcastsToCache(_favoritePodcasts);
    }
  }
}
