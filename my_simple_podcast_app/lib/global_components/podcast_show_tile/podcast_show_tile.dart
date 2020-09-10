import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/podcast_show_tile/widgets/cover_art_widget.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:my_simple_podcast_app/global_models/podcast_show.dart';

import 'widgets/show_information/show_information_widget.dart';

class PodcastShowTile extends StatelessWidget {
  const PodcastShowTile(
      {@required this.podcastShow, @required this.maxTileSize});
  final PodcastShow podcastShow;
  final double maxTileSize;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight * maxTileSize,
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CoverArt(
                  imageUrl: podcastShow.imageUrl,
                ),
              ),
              Expanded(
                flex: 4,
                child: ShowInformation(
                  podcastShow: podcastShow,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
