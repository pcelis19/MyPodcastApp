import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:my_simple_podcast_app/global_services/favorite_podcasts/favorites_podcasts_service.dart';

// constants for the following name fields
const String PODCAST_ID = "podcastId";
const String PODCAST_NAME = "podcastName";
const String ARTIST_NAME = "artistName";
const String IMAGE_URL = "imageUrl";
const String FEED_URL = "feedUrl";
const String RELEASE_DATE = "releaseDate";
const String CONTENT_ADVISORY_RATING = "contentAdvisoryRating";
const String COUNTRY = "country";
const String GENRES = "genres";

class Podcast with ChangeNotifier {
  // Data members
  /// the name of owner of the show
  final String artistName;

  /// identifys if the podcast is 'clean' or 'explicit'
  final String contentAdvisoryRating;

  /// origin of the podcast
  final String country;

  /// link to the RssFeed
  final String feedUrl;

  /// set of genres
  final List<String> genres;

  /// podcast's link to their podcast image
  final String imageUrl;

  /// unique identifier
  final int podcastId;

  /// name of the podcast
  final String podcastName;

  /// when the podcast was release
  final String
      releaseDate; // TODO check what the release date relates to. Last updated? or when released

  /// constructor
  Podcast({
    @required this.podcastId,
    @required this.artistName,
    @required this.contentAdvisoryRating,
    @required this.country,
    @required this.feedUrl,
    @required this.genres,
    @required this.imageUrl,
    @required this.podcastName,
    @required this.releaseDate,
  });

  /// constructor from json
  Podcast.fromJson(Map<String, dynamic> json)
      : podcastId = json[PODCAST_ID],
        artistName = json[ARTIST_NAME],
        contentAdvisoryRating = json[CONTENT_ADVISORY_RATING],
        country = json[COUNTRY],
        feedUrl = json[FEED_URL],
        genres = List<String>.from(json[GENRES]),
        imageUrl = json[IMAGE_URL],
        podcastName = json[PODCAST_NAME],
        releaseDate = json[RELEASE_DATE];

  /// whether the podcast has focus from an outside widget
  bool _hasFocus = false;

  /// returns whether a podcast has focus
  bool get hasFocus {
    return _hasFocus;
  }

  /// removes focus from the podcast
  void removeFocus() {
    _hasFocus = false;
    notifyListeners();
  }

  /// gives the podcast focus

  void giveFocus() {
    _hasFocus = true;
    notifyListeners();
  }

  /// makes the object into a json file
  Map<String, dynamic> toJson() {
    return {
      ARTIST_NAME: artistName,
      CONTENT_ADVISORY_RATING: contentAdvisoryRating,
      COUNTRY: country,
      FEED_URL: feedUrl,
      GENRES: genres,
      IMAGE_URL: imageUrl,
      PODCAST_ID: podcastId,
      PODCAST_NAME: podcastName,
      RELEASE_DATE: releaseDate,
    };
  }

  /// returns if the podcast is favorite from cache
  Future<bool> get isFavorited async {
    return await FavoritePodcastsService().isPodcastFavorite(this);
  }

  /// if the podcast is not a favorite, then it will unfavorite
  /// it, or vice versa, i.e., if it is a favorite then it will
  /// remove it from favorites
  Future<void> toggleFavorites() async {
    bool isFavorite = await isFavorited;
    if (isFavorite) {
      log("_removedFromFavorites");
      _removeFromFavorites();
    } else {
      log("_addToFavorites");
      _addToFavorites();
    }
    notifyListeners();
  }

  /// removes podcast from favorites in the cache
  Future<void> _removeFromFavorites() async {
    await FavoritePodcastsService().removePodcastFromFavorites(this);
  }

  /// adds the podcast to favorites in the cache
  Future<void> _addToFavorites() async {
    await FavoritePodcastsService().addPodcastToFavorites(this);
  }

  @override
  bool operator ==(other) {
    return other is Podcast && other.podcastId == this.podcastId;
  }
}
