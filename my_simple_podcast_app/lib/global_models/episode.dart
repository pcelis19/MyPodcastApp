import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/global_utils/converters.dart';

class Episode {
  final String episodeName;
  final String episodeDuration;
  final String audioSourceUrl;
  final PartialPodcastInformation partialPodcastInformation;
  Episode({
    String audioSourceUrl,
    Duration episodeDuration,
    this.episodeName,
    this.partialPodcastInformation,
  })  : episodeDuration = kEpisodeDurationConverter(episodeDuration),
        audioSourceUrl = kHttpsUrlRequest(audioSourceUrl);
}
