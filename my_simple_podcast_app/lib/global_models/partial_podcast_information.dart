import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:my_simple_podcast_app/global_services/favorite_podcasts/favorites_podcasts_service.dart';

// constants for the following name fields

const String PODCAST_NAME = "podcastName";
const String ARTIST_NAME = "artistName";
const String IMAGE_URL = "imageUrl";
const String FEED_URL = "feedUrl";
const String RELEASE_DATE = "releaseDate";
const String CONTENT_ADVISORY_RATING = "contentAdvisoryRating";
const String COUNTRY = "country";
const String GENRES = "genres";

class PartialPodcastInformation with ChangeNotifier {
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

  /// name of the podcast
  final String podcastName;

  /// when the podcast was release
  final String
      releaseDate; // TODO check what the release date relates to. Last updated? or when released

  /// constructor
  PartialPodcastInformation({
    @required this.artistName,
    String contentAdvisoryRating,
    @required this.country,
    @required this.feedUrl,
    @required this.genres,
    @required this.imageUrl,
    @required this.podcastName,
    @required this.releaseDate,
  }) : this.contentAdvisoryRating = contentAdvisoryRating == null ||
                contentAdvisoryRating.toLowerCase() == 'explicit'
            ? 'explicit'
            : '';

  /// constructor from json
  PartialPodcastInformation.fromJson(Map<String, dynamic> json)
      : artistName = json[ARTIST_NAME],
        contentAdvisoryRating = json[CONTENT_ADVISORY_RATING],
        country = json[COUNTRY],
        feedUrl = json[FEED_URL],
        genres = List<String>.from(json[GENRES]),
        imageUrl = json[IMAGE_URL],
        podcastName = json[PODCAST_NAME],
        releaseDate = json[RELEASE_DATE];

  /// makes the object into a json file
  Map<String, dynamic> toJson() {
    return {
      ARTIST_NAME: artistName,
      CONTENT_ADVISORY_RATING: contentAdvisoryRating,
      COUNTRY: country,
      FEED_URL: feedUrl,
      GENRES: genres,
      IMAGE_URL: imageUrl,
      PODCAST_NAME: podcastName,
      RELEASE_DATE: releaseDate,
    };
  }

  /// returns if the podcast is favorite from cache
  bool isFavorited() {
    return FavoritePodcastsService().isPodcastFavorite(this);
  }

  /// if the podcast is not a favorite, then it will unfavorite
  /// it, or vice versa, i.e., if it is a favorite then it will
  /// remove it from favorites
  Future<void> toggleFavorites() async {
    bool isFavorite = isFavorited();
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
  // ignore: hash_and_equals
  bool operator ==(other) {
    if (other is PartialPodcastInformation) {
      if (this.feedUrl != null && other.feedUrl != null) {
        return this.feedUrl == other.feedUrl;
      } else if (this.feedUrl == null && other.feedUrl == null) {
        // if both objects have null ids, then check their names + artist name
        String str1 = podcastName + artistName;
        String str2 = other.podcastName + other.artistName;
        return str1.compareTo(str2) == 0;
      } else {
        // if one object has null, but the other doesn't then return false
        return false;
      }
    }
    // default, object being compared to is not a Podcast
    return false;
  }
}
