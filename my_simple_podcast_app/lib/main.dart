import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/views/settings.dart';
import 'package:provider/provider.dart';

import 'constants/route_names.dart';
import 'models/partial_podcast_information.dart';
import 'services/audio_player/audio_player.dart';
import 'services/favorite_podcasts/favorites_podcasts_service.dart';
import 'services/user_settings.dart';
import 'views/audio_player_view.dart';
import 'views/home.dart';
import 'views/podcast_show_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritePodcastsService().intializeFavorites();
  await AudioPlayer().intializeAudioPlayer();
  await UserSettings().initializeUserSettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoritePodcastsService(),
        ),
      ],
      child: MyApp(),
    ),
  );
  AudioPlayer().dispose();
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
          case kPodcastHomeView:
            return MaterialPageRoute(
              builder: (context) => PodcastHomeScreen(
                partialPodcastInformation:
                    (settings.arguments as PartialPodcastInformation),
              ),
            );
          case kAudioPlayerView:
            return MaterialPageRoute(
              builder: (context) => PlayerHomeScreen(),
            );
          case kSettingsView:
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
