import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/components/list_of_podcast_banners.dart';
import 'package:my_simple_podcast_app/constants/decorations.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/services/podcast_search/podcast_search_service.dart';
import 'package:my_simple_podcast_app/services/user_settings.dart';
import 'package:my_simple_podcast_app/utils/size_config.dart';
import 'package:my_simple_podcast_app/widgets/podcast_banner.dart';

class TopPodcasts extends StatelessWidget {
  final UserSettings _userSetting = UserSettings();
  final PodcastSearchService _podcastSearchService = PodcastSearchService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userSetting.displayTodaysTopPodcastStream,
      builder: (builder, snapshot) {
        if (snapshot.hasData) {
          bool displayTopPodcasts =
              snapshot.data; // whether the top podcasts should be displayed
          if (displayTopPodcasts)
            return getDefault(context);
          else
            return SliverToBoxAdapter(child: Container());
        } else
          return getDefault(context);
      },
    );
  }

  Widget getDefault(BuildContext context) {
    double height = SizeConfig.screenHeight * (kBannerPercentHeight);
    double width = SizeConfig.screenWidth;
    return FutureBuilder<List<PartialPodcastInformation>>(
      future: _podcastSearchService.topPodcasts,
      builder: (BuildContext context,
          AsyncSnapshot<List<PartialPodcastInformation>> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          child = ListOfPodcastBanners(listOfPodcasts: snapshot.data);
        } else {
          if (snapshot.hasError) {
            child = Center(
              child: Column(
                children: [
                  Icon(Icons.history),
                  Text('Failed Fetch Top Podcast :('),
                ],
              ),
            );
          } else {
            // TODO: remove this, and add a loading indicator
            child = Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        return SliverToBoxAdapter(
          child: Container(
            height: height,
            width: width,
            child: child,
          ),
        );
      },
    );
  }
}
