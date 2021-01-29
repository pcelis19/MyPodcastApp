import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_utils/route_names.dart';
import 'package:my_simple_podcast_app/views/home/home_screen.dart';
import 'package:my_simple_podcast_app/views/podcast_home_screen/podcast_home_screen.dart';
import 'package:provider/provider.dart';

import 'global_models/partial_podcast_information.dart';
import 'global_services/audio_player/audio_player.dart';
import 'global_services/favorite_podcasts/favorites_podcasts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritePodcastsService().intializeFavorites();
  await AudioPlayer().intializeAudioPlayer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FavoritePodcastsService _favoritePodcastsService =
      FavoritePodcastsService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: _favoritePodcastsService,
          ),
          ChangeNotifierProvider.value(
            value: _audioPlayer,
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.indigo, accentColor: Colors.redAccent),
            routes: {
              kDefault: (context) => HomePage(),
              kPodcastHomeScreen: (context) => PodcastHomeScreen(
                    partialPodcastInformation: (ModalRoute.of(context)
                        .settings
                        .arguments as PartialPodcastInformation),
                  )
            },
          );
        });
  }
}
