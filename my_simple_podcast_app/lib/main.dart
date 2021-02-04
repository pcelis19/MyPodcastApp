import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_services/user_settings.dart';
import 'package:my_simple_podcast_app/global_utils/route_names.dart';
import 'package:my_simple_podcast_app/views/home/home_screen.dart';
import 'package:my_simple_podcast_app/views/podcast_home_screen/podcast_home_screen.dart';
import 'package:my_simple_podcast_app/views/settings/settings.dart';
import 'package:provider/provider.dart';

import 'global_models/partial_podcast_information.dart';
import 'global_services/audio_player/audio_player.dart';
import 'global_services/favorite_podcasts/favorites_podcasts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritePodcastsService().intializeFavorites();
  await AudioPlayer().intializeAudioPlayer();
  await UserSettings().initializeUserSettings();
  final FavoritePodcastsService _favoritePodcastsService =
      FavoritePodcastsService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _favoritePodcastsService,
        ),
        ChangeNotifierProvider.value(
          value: _audioPlayer,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.redAccent,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case kDefault:
            return MaterialPageRoute(
              builder: (context) => HomePage(),
            );

          case kPodcastHomeScreen:
            return MaterialPageRoute(
              builder: (context) => PodcastHomeScreen(
                partialPodcastInformation: (ModalRoute.of(context)
                    .settings
                    .arguments as PartialPodcastInformation),
              ),
            );
          case kSettings:
            return MaterialPageRoute(
              builder: (context) => UserSettingsPage(),
            );
          default:
            throw UnimplementedError('no route for $settings');
        }
      },
    );
  }
}
