import 'package:my_simple_podcast_app/models/podcast_show.dart';
import 'package:my_simple_podcast_app/services/shared_preferences_service.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastSearchService {
  /// Creation of singleton
  static final PodcastSearchService _podcastSearchService =
      PodcastSearchService._internal();
  factory PodcastSearchService() {
    return _podcastSearchService;
  }
  PodcastSearchService._internal();

  /// instance variables

  Search _search = Search();

  /// instance methods

  /// returns a list of podcast shows with a given search [searchTerm]
  Future<List<PodcastShow>> searchTerm(String searchTerm) async {
    await SharedPreferencesService().addSearchTerm(searchTerm);
    SearchResult searchResult = await _search.search(searchTerm);
    List<Item> results = searchResult.items;
    List<PodcastShow> podcastShows = List<PodcastShow>();
    for (Item result in results) {
      Set<String> genres = Set<String>();
      result.genre.forEach((element) {
        genres.add(element.name.toLowerCase());
      });
      PodcastShow podcastShow = PodcastShow(
          artistName: result.artistName,
          contentAdvisoryRating: result.contentAdvisoryRating,
          country: result.country,
          feedUrl: result.feedUrl,
          genres: genres,
          imageUrl: result.artworkUrl600,
          releaseDate: result.releaseDate,
          showName: result.collectionName);
      podcastShows.add(podcastShow);
    }
    return podcastShows;
  }

  /// checks if there is cache.
  /// * Returns the following
  /// ** if no cache returns null
  /// ** else returns List<String>
  Future<List<String>> get previousSearchTerms async {
    return await SharedPreferencesService().previousSearchTerms;
  }
}
