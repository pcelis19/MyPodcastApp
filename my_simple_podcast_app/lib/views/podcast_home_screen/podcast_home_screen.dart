import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';

import 'widgets/podcast_episodes.dart';
import 'widgets/podcast_header.dart';

class PodcastHomeScreen extends StatelessWidget {
  final PartialPodcastInformation partialPodcastInformation;

  const PodcastHomeScreen({Key key, this.partialPodcastInformation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    Color _backgroundColor = _themeData.primaryColorLight;
    return Container(
      height: double.infinity,
      color: _backgroundColor,
      child: SafeArea(
        child: Container(
          color: _backgroundColor,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => log("Back  Button Pressed"),
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
                    child: PodcastEpisodes(
                        partialPodcastInformation: partialPodcastInformation),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
