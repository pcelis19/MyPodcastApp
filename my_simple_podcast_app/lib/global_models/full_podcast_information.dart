import 'package:flutter/widgets.dart';
import 'package:my_simple_podcast_app/global_models/episode.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';

class FullPodcastInformation extends PartialPodcastInformation {
  List<Episode> podcastEpisodes;
  String description;
  FullPodcastInformation({
    ///FullPodcastInformation parameters
    @required this.podcastEpisodes,
    @required this.description,

    /// inheritance parameters
    @required int podcastId,
    @required String artistName,
    String contentAdvisoryRating,
    @required String country,
    @required String feedUrl,
    @required List<String> genres,
    @required String imageUrl,
    @required String podcastName,
    @required String releaseDate,
  }) : super(
            podcastId: podcastId,
            artistName: artistName,
            contentAdvisoryRating: contentAdvisoryRating,
            country: country,
            feedUrl: feedUrl,
            genres: genres,
            imageUrl: imageUrl,
            podcastName: podcastName,
            releaseDate: releaseDate) {}
}
