import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/components/list_of_episodes.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/widgets/podcast_header.dart';

class PodcastHomeScreen extends StatelessWidget {
  final PartialPodcastInformation partialPodcastInformation;

  const PodcastHomeScreen({Key key, this.partialPodcastInformation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(partialPodcastInformation.podcastName),
          centerTitle: true,
        ),
        body: Column(
          children: [
            /// Show Details
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PodcastHeader(
                  partialPodcastInformation: partialPodcastInformation,
                ),
              ),
            ),

            /// Show Description and Episodes
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListOfEpisodes(
                    partialPodcastInformation: partialPodcastInformation),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
