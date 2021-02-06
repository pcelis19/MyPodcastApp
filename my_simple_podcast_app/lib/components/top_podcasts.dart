import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/services/podcast_search/podcast_search_service.dart';
import 'package:my_simple_podcast_app/services/user_settings.dart';
import 'package:provider/provider.dart';

import 'list_of_podcast_banners.dart';

class TopPodcasts extends StatelessWidget {
  final UserSettings _userSetting = UserSettings();
  final PodcastSearchService _podcastSearchService = PodcastSearchService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userSetting.displayTodaysTopPodcastStream,
      builder: (builder, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data)
            return getDefault(context);
          else
            return Container();
        } else
          return getDefault(context);
      },
    );
  }

  Widget getDefault(BuildContext context) {
    return Expanded(
      child: Container(
        child: FutureBuilder<List<PartialPodcastInformation>>(
          future: _podcastSearchService.topPodcasts,
          builder: (BuildContext context,
              AsyncSnapshot<List<PartialPodcastInformation>> snapshot) {
            if (snapshot.hasData) {
              return Provider<List<PartialPodcastInformation>>.value(
                value: snapshot.data,
                child: ListOfPodcastBanners(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Icon(Icons.history),
                    Text('Failed Fetch Top Podcast :('),
                  ],
                ),
              );
            } else {
              // TODO: remove this, and add a loading indicator
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
