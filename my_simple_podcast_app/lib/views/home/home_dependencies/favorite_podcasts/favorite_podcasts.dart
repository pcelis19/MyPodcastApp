import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/global_services/favorite_podcasts/favorites_podcasts_service.dart';
import 'package:my_simple_podcast_app/global_services/user_settings.dart';
import 'package:my_simple_podcast_app/global_utils/route_names.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:provider/provider.dart';

class FavoritePodcasts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: UserSettings().displayTodaysTopPodcastStream,
        builder: (context, snapdata) {
          double height = SizeConfig.screenHeight * .50; // default
          double maxHeightDefault = SizeConfig.screenHeight;
          // if the stream has data, and user opts to not see
          // top podcasts, then take the entire space
          if (snapdata.hasData && !snapdata.data) {
            height = maxHeightDefault;
          }
          final ThemeData themeData = Theme.of(context);
          return ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: height, maxWidth: double.infinity),
            child: Consumer<FavoritePodcastsService>(
              builder: (context, favoritePodcastsService, child) {
                List<PartialPodcastInformation> podcasts =
                    favoritePodcastsService.favoritePodcasts;
                if (podcasts == null || podcasts.isEmpty) {
                  return Center(
                    child: Text(
                      'Don\'t forget to press the heart icon to favorite shows',
                      style: themeData.primaryTextTheme.headline3,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: podcasts.length + 1,
                    itemBuilder: (context, i) {
                      if (i < podcasts.length) {
                        PartialPodcastInformation podcast = podcasts[i];

                        return Card(
                          elevation: 5,
                          child: OutlineButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  kPodcastHomeScreen,
                                  arguments: podcast);
                            },
                            child: ListTile(
                              isThreeLine: true,
                              leading: Image.network(podcast.imageUrl),
                              title: Text(podcast.podcastName),
                              subtitle: Text(podcast.artistName),
                              trailing: podcast.contentAdvisoryRating != null
                                  ? Text(podcast.contentAdvisoryRating)
                                  : Text('Explicit'),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 400,
                        );
                      }
                    },
                  );
                }
              },
            ),
          );
        });
  }
}
