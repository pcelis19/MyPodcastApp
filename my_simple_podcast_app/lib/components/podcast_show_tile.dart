import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';

import 'widgets/cover_art_widget/cover_art_widget.dart';
import 'widgets/show_information/show_information_widget.dart';

/// Make sure to wrap this in a constrainted box, or else it may throw
/// UI error
class PodcastShowTile extends StatelessWidget {
  const PodcastShowTile({@required this.partialPodcastInformation});
  final PartialPodcastInformation partialPodcastInformation;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: coverArt,
              ),
              Expanded(
                flex: 4,
                child: showInformation,
              )
            ],
          ),
        ),
      ),
    );
  }
}
