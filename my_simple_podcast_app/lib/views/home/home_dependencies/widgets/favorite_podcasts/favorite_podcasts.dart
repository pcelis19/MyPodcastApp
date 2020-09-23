import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:my_simple_podcast_app/global_services/favorites_podcasts_service.dart';

class FavoritePodcasts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return StreamBuilder<List<Podcast>>(
      stream: FavoritePodcastsService().favoritePodcasts,
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
            return Center(
              child: Text(
                'Oh oh, an error occurred!',
                style: themeData.primaryTextTheme.headline3,
              ),
            );
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
  }
}
