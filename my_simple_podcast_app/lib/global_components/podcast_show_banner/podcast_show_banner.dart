import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/podcast_show_tile/widgets/cover_art_widget/cover_art_widget.dart';
import 'package:my_simple_podcast_app/global_models/podcast_show.dart';

class PodcastShowBanner extends StatelessWidget {
  const PodcastShowBanner({Key key, @required this.podcastShow})
      : super(key: key);
  final PodcastShow podcastShow;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoverArt(imageUrl: podcastShow.imageUrl),
        Text(podcastShow.showName),
        Text(podcastShow.artistName),
      ],
    );
  }
}
