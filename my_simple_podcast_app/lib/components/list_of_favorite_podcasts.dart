import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/route_names.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/services/favorite_podcasts/favorites_podcasts_service.dart';
import 'package:my_simple_podcast_app/services/user_settings.dart';
import 'package:provider/provider.dart';

class ListOfFavoritePodcasts extends StatelessWidget {
  final UserSettings _userSettings = UserSettings();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _userSettings.displayTodaysTopPodcastStream,
        builder: (context, snapdata) {
          // if the stream has data, and user opts to not see
          // top podcasts, then take the entire space

          final ThemeData themeData = Theme.of(context);
          return Selector<FavoritePodcastsService,
              List<PartialPodcastInformation>>(
            selector: (_, favoritePodcastsService) =>
                favoritePodcastsService.favoritePodcasts,
            builder: (context, favoritePodcasts, child) {
              if (favoritePodcasts == null || favoritePodcasts.isEmpty) {
                /// if the user has not saved anything, then just remind them to
                /// start favoriting items
                /// otherwise display their list of favorites, with an additional
                /// padding at the end
                return Center(
                  child: Text(
                    'Don\'t forget to press the heart icon to favorite shows',
                    style: themeData.primaryTextTheme.headline3,
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      if (i < favoritePodcasts.length) {
                        PartialPodcastInformation podcast = favoritePodcasts[i];
                        return Card(
                          elevation: 5,
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushNamed(kPodcastHomeView,
                                  arguments: podcast);
                            },
                            elevation: 8,
                            child: ListTile(
                              isThreeLine: true,
                              leading: Hero(
                                  tag: podcast.imageUrl,
                                  child: Image.network(podcast.imageUrl)),
                              title: Text(podcast.podcastName),
                              subtitle: Text(podcast.artistName),
                              trailing: podcast.contentAdvisoryRating != null
                                  ? Text(podcast.contentAdvisoryRating)
                                  : Text('Explicit'),
                            ),
                          ),
                        );
                      } else {
                        // this is padding for the very end
                        return Container(
                          height: 400,
                        );
                      }
                    },
                    childCount: favoritePodcasts.length + 1,
                  ),
                );
              }
            },
          );
        });
  }
}
