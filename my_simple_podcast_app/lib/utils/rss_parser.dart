import 'package:my_simple_podcast_app/models/episode.dart';
import 'package:my_simple_podcast_app/models/full_podcast_information.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:podcast_search/podcast_search.dart' as rssParser;

/**
   *  Accepts a partial podcast
   *  @returns full podcast information
   */
Future<FullPodcastInformation> fetchEpisodes(
    PartialPodcastInformation partialPodcastInformation) async {
  List<Episode> fetchedEpisodes = <Episode>[];
  FullPodcastInformation fullPodcastInformation;
  await rssParser.Podcast.loadFeed(partialPodcastInformation.feedUrl)
      .then((value) {
    value.episodes.forEach((element) {
      fetchedEpisodes.add(
        Episode(
          episodeName: element.title,
          audioSourceUrl: element.contentUrl,
          episodeDuration: element.duration,
          partialPodcastInformation: partialPodcastInformation,
        ),
      );
    });
    fullPodcastInformation = FullPodcastInformation(
      artistName: partialPodcastInformation.artistName,
      country: partialPodcastInformation.country,
      description: value.description,
      feedUrl: partialPodcastInformation.feedUrl,
      genres: partialPodcastInformation.genres,
      imageUrl: partialPodcastInformation.imageUrl,
      podcastEpisodes: fetchedEpisodes,
      podcastName: partialPodcastInformation.podcastName,
      releaseDate: partialPodcastInformation.releaseDate,
    );
  });
  return fullPodcastInformation;
}

/// todo: make compute work with current app, for some reason it doesn't like to load
// Future<FullPodcastInformation> fetchEpisodes(
//     PartialPodcastInformation partialPodcastInformation) async {
//   final List<Episode> fetchedEpisodes = <Episode>[];
//   FullPodcastInformation fullPodcastInformation;
//   rssParser.Podcast podcast = await compute<String, rssParser.Podcast>(
//       rssParser.Podcast.loadFeed, partialPodcastInformation.feedUrl);
//   await compute(
//       (List<rssParser.Episode> episodes) => episodes.forEach(
//             (element) => fetchedEpisodes.add(
//               Episode(
//                   episodeName: element.title,
//                   audioSourceUrl: element.contentUrl,
//                   episodeDuration: element.duration,
//                   partialPodcastInformation: partialPodcastInformation),
//             ),
//           ),
//       podcast.episodes);

//   fullPodcastInformation = FullPodcastInformation(
//       artistName: partialPodcastInformation.artistName,
//       country: partialPodcastInformation.country,
//       description: podcast.description,
//       feedUrl: partialPodcastInformation.feedUrl,
//       genres: partialPodcastInformation.genres,
//       imageUrl: partialPodcastInformation.imageUrl,
//       podcastEpisodes: fetchedEpisodes,
//       podcastName: partialPodcastInformation.podcastName,
//       releaseDate: partialPodcastInformation.releaseDate);

//   return fullPodcastInformation;
// }
