import 'package:my_simple_podcast_app/global_models/podcast.dart';

class Episode {
  final String episodeName;
  final Duration _episodeDuration;
  final String audioSourceUrl;
  final Podcast podcast;
  Episode(
      {this.audioSourceUrl,
      this.episodeName,
      Duration episodeDuration,
      this.podcast})
      : _episodeDuration = episodeDuration;
  String get episodeDuration {
    if (_episodeDuration == null) {
      return null;
    } else {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes =
          twoDigits(_episodeDuration.inMinutes.remainder(60));
      String twoDigitSeconds =
          twoDigits(_episodeDuration.inSeconds.remainder(60));
      return "${twoDigits(_episodeDuration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}
