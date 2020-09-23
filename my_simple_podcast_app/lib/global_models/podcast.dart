import 'package:flutter/foundation.dart';
import 'package:my_simple_podcast_app/global_services/favorites_podcasts_service.dart';
import 'package:my_simple_podcast_app/views/home/home_dependencies/widgets/favorite_podcasts/favorite_podcasts.dart';

const String PODCAST_ID = "podcastId";
const String ARTIST_NAME = "artistName";
const String SHOW_NAME = "showName";
const String IMAGE_URL = "imageUrl";
const String FEED_URL = "feedUrl";
const String RELEASE_DATE = "releaseDate";
const String CONTENT_ADVISORY_RATING = "contentAdvisoryRating";
const String COUNTRY = "country";
const String GENRES = "genres";

class Podcast with ChangeNotifier {
  Podcast(
      {@required this.artistName,
      @required this.showName,
      @required this.imageUrl,
      @required this.feedUrl,
      @required this.releaseDate,
      @required this.contentAdvisoryRating,
      @required this.country,
      @required this.genres,
      @required this.podcastId});
  final int podcastId;
  final String artistName;
  final String feedUrl;
  final String showName;
  final String imageUrl;
  final DateTime releaseDate;
  final String contentAdvisoryRating;
  final String country;
  Set<String> genres;

  bool _hasFocus = false;
  bool get hasFocus {
    return _hasFocus;
  }

  void removeFocus() {
    _hasFocus = false;
    notifyListeners();
  }

  void giveFocus() {
    _hasFocus = true;
    notifyListeners();
  }

  Map<String, dynamic> get toJsonObject {
    return {
      PODCAST_ID: podcastId,
      ARTIST_NAME: artistName,
      SHOW_NAME: showName,
      IMAGE_URL: imageUrl,
      FEED_URL: feedUrl,
      RELEASE_DATE: releaseDate,
      CONTENT_ADVISORY_RATING: contentAdvisoryRating,
      COUNTRY: country,
      GENRES: genres,
    };
  }

  Future<bool> get isFavorited async {
    return await FavoritePodcastsService().isFavorite(this);
  }

  Future<void> removeFromFavorites() async {
    await FavoritePodcastsService().removePodcastFromFavorites(this);
  }

  Future<void> addToFavorites() async {
    await FavoritePodcastsService().addPodcastToFavorites(this);
  }
}
