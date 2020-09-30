import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:my_simple_podcast_app/global_utils/route_names.dart';
import 'package:my_simple_podcast_app/views/podcast_home_screen/podcast_home_screen.dart';

import 'global_services/favorite_podcasts/favorites_podcasts_service.dart';
import 'views/app_skeleton_with_bar/app_skeleton_with_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritePodcastsService().intializeFavorites();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo, accentColor: Colors.redAccent),
      routes: {
        kDefault: (context) => AppSkeletonWithBar(),
        kPodcastHomeScreen: (context) => PodcastHomeScreen(
              podcast: (ModalRoute.of(context).settings.arguments as Podcast),
            )
      },
    );
  }
}
