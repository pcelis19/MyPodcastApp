import 'package:my_simple_podcast_app/utils/converters.dart';

import 'partial_podcast_information.dart';

const String EPISODE_NAME = "episodeName";
const String EPISODE_DURATION = "episodeDuration";
const String AUDIO_SOURCE_URL = "audioSourceUrl";
const String PARTIAL_PODCAST_INFORMATION = "partialPodcastInformation";

class Episode {
  final String episodeName;
  final String episodeDuration;
  final String audioSourceUrl;
  // final PartialPodcastInformation partialPodcastInformation;
  PartialPodcastInformation partialPodcastInformation;
  Episode({
    String audioSourceUrl,
    Duration episodeDuration,
    this.episodeName,
    this.partialPodcastInformation,
  })  : episodeDuration = kEpisodeDurationConverter(episodeDuration),
        audioSourceUrl = kHttpsUrlRequest(audioSourceUrl);

  Episode.fromJson(Map<String, dynamic> jsonData)
      : episodeName = jsonData[EPISODE_NAME],
        episodeDuration = jsonData[EPISODE_DURATION],
        audioSourceUrl = jsonData[AUDIO_SOURCE_URL],
        partialPodcastInformation = PartialPodcastInformation.fromJson(
            jsonData[PARTIAL_PODCAST_INFORMATION]);

  /// makes the object into a json file
  Map<String, dynamic> toJson() {
    return {
      EPISODE_NAME: episodeName,
      EPISODE_DURATION: episodeDuration,
      AUDIO_SOURCE_URL: audioSourceUrl,
      PARTIAL_PODCAST_INFORMATION: partialPodcastInformation.toJson()
    };
  }

  bool operator ==(Object object) =>
      object is Episode && this.audioSourceUrl == object.audioSourceUrl;
}
