import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:my_simple_podcast_app/global_services/favorite_podcasts/favorites_podcasts_service.dart';
import 'package:provider/provider.dart';

class FavoritePodcasts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
      child: Consumer<FavoritePodcastsService>(
        builder: (context, favoritePodcastsService, child) {
          return FutureBuilder<List<Podcast>>(
            future: favoritePodcastsService.favoritePodcasts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null || snapshot.data.isEmpty) {
                  return Center(
                    child: Text(
                      'Don\'t forget to press the heart icon to favorite shows',
                      style: themeData.primaryTextTheme.headline3,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Text(snapshot.data[i].artistName);
                      });
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Oh oh, an error occurred!',
                    style: themeData.primaryTextTheme.headline3,
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }
}
