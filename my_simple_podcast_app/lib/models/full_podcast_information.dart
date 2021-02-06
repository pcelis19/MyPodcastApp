import 'package:flutter/widgets.dart';
import 'package:my_simple_podcast_app/global_models/episode.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';

/// unlike [PartialPodcastInformation], [FullPodcastInformation] has all the information
/// of a podcast show and, therefore a lot more data members
class FullPodcastInformation extends PartialPodcastInformation {
  List<Episode> podcastEpisodes;
  String description;
  FullPodcastInformation({
    ///FullPodcastInformation parameters
    @required this.podcastEpisodes,
    @required this.description,
    @required String artistName,
    String contentAdvisoryRating,
    @required String country,
    @required String feedUrl,
    @required List<String> genres,
    @required String imageUrl,
    @required String podcastName,
    @required String releaseDate,
  }) : super(
            artistName: artistName,
            contentAdvisoryRating: contentAdvisoryRating,
            country: country,
            feedUrl: feedUrl,
            genres: genres,
            imageUrl: imageUrl,
            podcastName: podcastName,
            releaseDate: releaseDate) {}
}
