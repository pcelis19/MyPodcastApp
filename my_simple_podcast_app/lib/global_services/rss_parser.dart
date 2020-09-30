import 'package:my_simple_podcast_app/global_models/episode.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:podcast_search/podcast_search.dart' as rssParser;

class RSSParser {
  Future<List<Episode>> fetchEpisodes(Podcast podcast) async {
    List<Episode> fetchedEpisodes = <Episode>[];
    await rssParser.Podcast.loadFeed(url: podcast.feedUrl).then((value) {
      value.episodes.forEach((element) {
        fetchedEpisodes.add(Episode(
            episodeName: element.title,
            audioSourceUrl: element.contentUrl,
            episodeDuration: element.duration,
            podcast: podcast));
      });
    });
    return fetchedEpisodes;
  }
}
