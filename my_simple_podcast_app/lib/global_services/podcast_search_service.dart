import 'dart:developer';

import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:my_simple_podcast_app/global_services/shared_preferences_service.dart';
import 'package:podcast_search/podcast_search.dart' as PodcastSearch;

const int LIMIT = 8;

//In global because used in both home screen and search screen
class PodcastSearchService {
  /// Creation of singleton
  static final PodcastSearchService _podcastSearchService =
      PodcastSearchService._internal();
  factory PodcastSearchService() {
    return _podcastSearchService;
  }
  PodcastSearchService._internal();

  /// instance variables

  PodcastSearch.Search _search = PodcastSearch.Search();

  Future<List<Podcast>> get topPodcasts async {
    // TODO get permissions from user so that country is relative to their
    // location
    PodcastSearch.SearchResult searchResult = await _search.charts(
        limit: LIMIT, country: PodcastSearch.Country.UNITED_STATES);
    List<Podcast> podcasts = [];
    for (PodcastSearch.Item result in searchResult.items) {
      Set<String> genres = Set<String>();
      result.genre.forEach((element) {
        genres.add(element.name.toLowerCase());
      });
      Podcast podcastShow = Podcast(
          artistName: result.artistName,
          contentAdvisoryRating: result.contentAdvisoryRating,
          country: result.country,
          feedUrl: result.feedUrl,
          genres: genres,
          imageUrl: result.artworkUrl600,
          releaseDate: result.releaseDate,
          showName: result.collectionName);
      podcasts.add(podcastShow);
    }
    return podcasts;
  }

  /// instance methods

  /// returns a list of podcast shows with a given search [searchTerm]
  Future<List<Podcast>> searchTerm(String searchTerm) async {
    try {
      await SharedPreferencesService().addSearchTerm(searchTerm);
    } catch (e) {
      log('[ERROR: SharedPreferencesService().addSearchTerm(searchTerm)]:[${e.toString()}]');
    }
    PodcastSearch.SearchResult searchResult = await _search.search(searchTerm);
    List<PodcastSearch.Item> results = searchResult.items;
    List<Podcast> podcasts = List<Podcast>();
    for (PodcastSearch.Item result in results) {
      Set<String> genres = Set<String>();
      result.genre.forEach((element) {
        genres.add(element.name.toLowerCase());
      });
      Podcast podcast = Podcast(
          artistName: result.artistName,
          contentAdvisoryRating: result.contentAdvisoryRating,
          country: result.country,
          feedUrl: result.feedUrl,
          genres: genres,
          imageUrl: result.artworkUrl600,
          releaseDate: result.releaseDate,
          showName: result.collectionName);
      podcasts.add(podcast);
    }
    return podcasts;
  }

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns empty List<String>
  /// ** else returns List<String>
  Future<List<dynamic>> get previousSearchTerms async {
    List<dynamic> previousSearchTerms = [];
    try {
      previousSearchTerms =
          await SharedPreferencesService().previousSearchTerms;
    } catch (e) {
      log("[ERROR: SharedPreferencesService().previousSearchTerms]: ${e.toString()}");
    }
    return previousSearchTerms;
  }
}
