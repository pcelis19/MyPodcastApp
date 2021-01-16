import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';

class PodcastHeader extends StatelessWidget {
  const PodcastHeader({
    Key key,
    @required this.partialPodcastInformation,
  }) : super(key: key);

  final PartialPodcastInformation partialPodcastInformation;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Image.network(partialPodcastInformation.imageUrl),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                partialPodcastInformation.podcastName,
                textAlign: TextAlign.center,
                style: _themeData.textTheme.headline6,
              ),
              AutoSizeText(
                partialPodcastInformation.artistName,
                textAlign: TextAlign.center,
                style: _themeData.textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
