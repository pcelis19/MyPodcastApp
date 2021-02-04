import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/global_services/podcast_search/podcast_search_service.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';

import 'widgets/list_podcast_banners.dart';

class TopPodcasts extends StatelessWidget {
  const TopPodcasts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double maxHeight = SizeConfig.safeBlockVertical * 50;
    return Container(
      child: FutureBuilder<List<PartialPodcastInformation>>(
        future: PodcastSearchService().topPodcasts,
        builder: (BuildContext context,
            AsyncSnapshot<List<PartialPodcastInformation>> snapshot) {
          if (snapshot.hasData) {
            return ListOfPodcastBanners(
              listOfPodcasts: snapshot.data,
              maxHeight: maxHeight,
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
    );
  }
}
