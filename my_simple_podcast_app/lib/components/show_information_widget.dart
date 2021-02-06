import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';

import 'podcast_show_tile/widgets/show_information/widgets/host_information.dart';
import 'podcast_show_tile/widgets/show_information/widgets/other_show_information.dart';
import 'podcast_show_tile/widgets/show_information/widgets/show_title.dart';

class ShowInformation extends StatelessWidget {
  const ShowInformation({
    Key key,
    @required this.podcastShow,
  }) : super(key: key);
  final PartialPodcastInformation podcastShow;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShowTitle(
          showName: podcastShow.podcastName,
        ),
        HostInformation(
          artistName: podcastShow.artistName,
        ),
        OtherShowInformation(
          partialPodcastInformation: podcastShow,
        )
      ],
    );
  }
}
